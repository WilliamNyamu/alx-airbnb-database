# Applying Normalization to the current database design

## Applying Normalization on the role attribute in the User entity
### Overview
 - The current design has a role field that enumerates the different roles - guest, host, admin - to a particular user. *However*, it is worth noting that a user can possess more than one role at the same time. For example, a user can be a host on their property but a guest on another person's property.
 - From the above example, the role attribute is not atomic because in the event a user possesses more than one role, the field would ceize being atomic. 
 - My approach would be therefore to apply Database Normalization and implement a many-to-many relationship between a user and a role

### Proposed normalization design
 - Creation of a role table with name(accepts role choices), description, created_at, updated_at
 - Creation of a UserRole - the junction table connecting the user and the role. This will store the user_id and the role_id
 - Implementing a Many-to-Many relationship from the user to the role through the UserRole

``` python
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils import timezone


class Role(models.Model):
    """Roles that users can have (guest, host, admin, etc.)"""
    
    GUEST = 'guest'
    HOST = 'host'
    ADMIN = 'admin'
    
    ROLE_CHOICES = [
        (GUEST, 'Guest'),
        (HOST, 'Host'),
        (ADMIN, 'Admin'),
    ]
    
    name = models.CharField(max_length=50, unique=True, choices=ROLE_CHOICES)
    description = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        db_table = 'roles'
        ordering = ['name']
    
    def __str__(self):
        return self.get_name_display()


class User(AbstractUser):
    """Custom User model extending Django's AbstractUser"""
    
    # AbstractUser already provides: username, email, password, first_name, last_name
    # We add our custom fields:
    
    phone_number = models.CharField(max_length=20, blank=True)
    location = models.CharField(max_length=255, blank=True)
    
    # Many-to-many relationship with Role
    roles = models.ManyToManyField(
        Role,
        through='UserRole',  # Use custom junction table
        related_name='users',
        blank=True
    )
    
    # Keep track of timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    class Meta:
        db_table = 'users'
        ordering = ['-created_at']
    
    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.email})"
    
    # Helper methods to check roles
    def is_guest(self):
        return self.roles.filter(name=Role.GUEST).exists()
    
    def is_host(self):
        return self.roles.filter(name=Role.HOST).exists()
    
    def is_admin(self):
        return self.roles.filter(name=Role.ADMIN).exists()
    
    def add_role(self, role_name):
        """Add a role to the user"""
        role = Role.objects.get(name=role_name)
        self.roles.add(role)
    
    def remove_role(self, role_name):
        """Remove a role from the user"""
        role = Role.objects.get(name=role_name)
        self.roles.remove(role)
    
    def get_role_names(self):
        """Get list of role names for this user"""
        return list(self.roles.values_list('name', flat=True))


class UserRole(models.Model):
    """Junction table for User-Role many-to-many relationship"""
    
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    role = models.ForeignKey(Role, on_delete=models.CASCADE)
    assigned_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        db_table = 'user_roles'
        unique_together = ('user', 'role')  # Prevent duplicate role assignments
        ordering = ['assigned_at']
    
    def __str__(self):
        return f"{self.user.email} - {self.role.name}"
```


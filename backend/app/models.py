from django.db import models
from django.contrib.auth.models import User, AbstractBaseUser, AbstractUser, BaseUserManager
# Create your models here.


class Todo(models.Model):
    todo_title = models.CharField(max_length=45)
    todo_description = models.TextField()
    todo_date =  models.DateTimeField()
    is_completed = models.BooleanField(default= False)

    def __str__(self):
        return self.todo_title

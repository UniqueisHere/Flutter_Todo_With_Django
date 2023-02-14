from django.contrib import admin
from .views import *
from .models import *


# Register your models here.
admin.site.register(Todo)
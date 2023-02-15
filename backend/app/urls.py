from django.urls import path
from .views import *

urlpatterns = [

    path('<int:pk>/', UpadateTodoView.as_view(), name='<int:pk>/'),
    path('', ReadTodoView.as_view(), name=''),
    path('create/', CreateTodoView.as_view(), name='create/'),
    path('delete/<int:pk>/', DeteleTodoView.as_view(), name='delete/<int:pk>/'),
]
from django.shortcuts import render
from rest_framework import generics
from .models import Todo
from rest_framework.generics import GenericAPIView
from .serializers import *
# Create your views here.


class ReadTodoView(generics.ListAPIView):           #Read all the values
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer

class UpadateTodoView(generics.UpdateAPIView):      #Update the created to do
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer
    


class CreateTodoView(generics.CreateAPIView):       #Create a new todo
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer



class DeteleTodoView(generics.DestroyAPIView):      #Delete created todo's
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer

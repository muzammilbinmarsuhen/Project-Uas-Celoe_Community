from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    pass

class Course(models.Model):
    title = models.CharField(max_length=255)
    semester = models.CharField(max_length=50, default='2021/2')
    progress = models.FloatField(default=0.0)
    thumbnail = models.URLField(blank=True, null=True)
    
    def __str__(self):
        return self.title

class Material(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE, related_name='materials')
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    completed = models.BooleanField(default=False)
    order = models.IntegerField(default=0)

    class Meta:
        ordering = ['order']

    def __str__(self):
        return self.title

class Attachment(models.Model):
    itm_type_choices = [
        ('video', 'Video'),
        ('pdf', 'PDF'),
        ('url', 'URL'),
        ('meeting', 'Zoom Meeting'),
    ]
    material = models.ForeignKey(Material, on_delete=models.CASCADE, related_name='attachments')
    type = models.CharField(max_length=20, choices=itm_type_choices)
    title = models.CharField(max_length=255)
    url = models.URLField()
    completed = models.BooleanField(default=False)
    
class Assignment(models.Model):
    STATUS_CHOICES = [
        ('not_started', 'Not Started'),
        ('in_progress', 'In Progress'),
        ('completed', 'Completed'),
    ]
    material = models.ForeignKey(Material, on_delete=models.CASCADE, related_name='assignments', null=True, blank=True)
    title = models.CharField(max_length=255)
    description = models.TextField()
    deadline = models.DateTimeField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='not_started')
    score = models.FloatField(null=True, blank=True)
    
class Quiz(models.Model):
    material = models.ForeignKey(Material, on_delete=models.CASCADE, related_name='quizzes', null=True, blank=True)
    title = models.CharField(max_length=255)
    duration_minutes = models.IntegerField()
    description = models.TextField(blank=True) # Added for details
    deadline = models.DateTimeField()
    # status/score handled by attempts or computed property

class QuizAttempt(models.Model):
    quiz = models.ForeignKey(Quiz, on_delete=models.CASCADE, related_name='attempts')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    start_time = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)
    score = models.FloatField(null=True, blank=True)

class Question(models.Model):
    quiz = models.ForeignKey(Quiz, on_delete=models.CASCADE, related_name='questions')
    question_text = models.TextField()

class Option(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name='options')
    text = models.CharField(max_length=255)
    is_correct = models.BooleanField(default=False)

class Submission(models.Model):
    assignment = models.ForeignKey(Assignment, on_delete=models.CASCADE, related_name='submissions')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    file_url = models.URLField()
    submitted_at = models.DateTimeField(auto_now_add=True)

class Notification(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='notifications')
    title = models.CharField(max_length=255)
    message = models.TextField()
    link = models.CharField(max_length=255, blank=True) # e.g. /classes/1/materials/10
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

from rest_framework import serializers
from .models import *

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name']

class AttachmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Attachment
        fields = ['id', 'type', 'title', 'url', 'completed']

class MaterialSerializer(serializers.ModelSerializer):
    # Depending on the view, we might include nested attachments or not
    # User spec for GET /classes/{id}/materials/ does NOT include attachments, just desc/completed
    class Meta:
        model = Material
        fields = ['id', 'title', 'description', 'completed']

class OptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Option
        fields = ['id', 'text'] # Don't expose 'is_correct' to frontend!

class QuestionSerializer(serializers.ModelSerializer):
    options = OptionSerializer(many=True, read_only=True)
    class Meta:
        model = Question
        fields = ['id', 'question_text', 'options']

class QuizSerializer(serializers.ModelSerializer):
    class Meta:
        model = Quiz
        fields = ['id', 'title', 'duration_minutes', 'deadline', 'description']

class AssignmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Assignment
        fields = ['id', 'title', 'deadline', 'status', 'score', 'description']

class CourseSerializer(serializers.ModelSerializer):
    # User spec for GET /classes/ only implies light data, but detailed view needs items?
    # Actually User spec says GET /api/classes/ returns id, title, semester, progress, thumbnail.
    class Meta:
        model = Course
        fields = ['id', 'title', 'semester', 'progress', 'thumbnail']

class SubmissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Submission
        fields = '__all__'

class QuizAttemptSerializer(serializers.ModelSerializer):
    class Meta:
        model = QuizAttempt
        fields = '__all__'

class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = ['title', 'message', 'link', 'is_read', 'created_at']

# Serializer for list items combining Quiz and Assignment for "Tasks and Quizzes" tab
class TaskQuizSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    type = serializers.CharField()
    title = serializers.CharField()
    deadline = serializers.DateTimeField()
    status = serializers.CharField(required=False)
    score = serializers.FloatField(required=False)

from rest_framework import viewsets, permissions, status
from rest_framework.response import Response
from rest_framework.decorators import action
from django.utils import timezone
from .models import *
from .serializers import *

class CourseViewSet(viewsets.ReadOnlyModelViewSet):
    """
    GET /api/classes/
    GET /api/classes/{id}/
    """
    queryset = Course.objects.all()
    serializer_class = CourseSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=True, methods=['get'])
    def materials(self, request, pk=None):
        """
        GET /api/classes/{id}/materials/
        """
        course = self.get_object()
        materials = course.materials.all()
        return Response(MaterialSerializer(materials, many=True).data)

    @action(detail=True, methods=['get'], url_path='tasks-quizzes')
    def tasks_quizzes(self, request, pk=None):
        """
        GET /api/classes/{id}/tasks-quizzes/
        Aggregation of all tasks/quizzes for the course
        """
        course = self.get_object()
        # Filter items where material's course is this course
        assignments = Assignment.objects.filter(material__course=course)
        quizzes = Quiz.objects.filter(material__course=course)
        
        combined_data = []
        for q in quizzes:
            combined_data.append({
                'id': q.id,
                'type': 'quiz',
                'title': q.title,
                'deadline': q.deadline,
                'status': 'not_started', 
                'score': None
            })
        for a in assignments:
            combined_data.append({
                'id': a.id,
                'type': 'assignment',
                'title': a.title,
                'deadline': a.deadline,
                'status': a.status,
                'score': a.score
            })
            
        return Response(TaskQuizSerializer(combined_data, many=True).data)

class MaterialViewSet(viewsets.ReadOnlyModelViewSet):
    """
    Mainly used for nested actions.
    """
    queryset = Material.objects.all()
    serializer_class = MaterialSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=True, methods=['get'])
    def attachments(self, request, pk=None):
        """
        GET /api/materials/{id}/attachments/
        """
        material = self.get_object()
        attachments = material.attachments.all()
        return Response(AttachmentSerializer(attachments, many=True).data)

    @action(detail=True, methods=['get'], url_path='tasks-quizzes')
    def tasks_quizzes(self, request, pk=None):
        """
        GET /api/materials/{id}/tasks-quizzes/
        Combines Assignments and Quizzes for this material
        """
        material = self.get_object()
        assignments = material.assignments.all()
        quizzes = material.quizzes.all()
        
        # Combine and format data manually or via serializer
        combined_data = []
        for q in quizzes:
            combined_data.append({
                'id': q.id,
                'type': 'quiz',
                'title': q.title,
                'deadline': q.deadline,
                # 'status' and 'score' to be fetched from user attempts ideally
                'status': 'not_started', 
                'score': None
            })
        for a in assignments:
            combined_data.append({
                'id': a.id,
                'type': 'assignment',
                'title': a.title,
                'deadline': a.deadline,
                'status': a.status,
                'score': a.score
            })
            
        return Response(TaskQuizSerializer(combined_data, many=True).data)


class AssignmentViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Assignment.objects.all()
    serializer_class = AssignmentSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=True, methods=['post'])
    def submit(self, request, pk=None):
        assignment = self.get_object()
        file_url = request.data.get('file_url')
        submission = Submission.objects.create(
            assignment=assignment,
            user=request.user,
            file_url=file_url
        )
        assignment.status = 'completed' # Simple logic update
        assignment.save()
        return Response(SubmissionSerializer(submission).data)

class QuizViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Quiz.objects.all()
    serializer_class = QuizSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=True, methods=['post'])
    def start(self, request, pk=None):
        """
        POST /api/quizzes/{id}/start/
        """
        quiz = self.get_object()
        attempt = QuizAttempt.objects.create(
            quiz=quiz,
            user=request.user
        )
        return Response({
            'attempt_id': attempt.id,
            'start_time': attempt.start_time
        })

    @action(detail=True, methods=['get'])
    def questions(self, request, pk=None):
        """
        GET /api/quizzes/{id}/questions/
        """
        quiz = self.get_object()
        questions = quiz.questions.all()
        return Response(QuestionSerializer(questions, many=True).data)

    @action(detail=True, methods=['post'])
    def submit(self, request, pk=None):
        """
        POST /api/quizzes/{id}/submit/
        """
        quiz = self.get_object()
        # Calculate score logic (mocked for simplicity as we don't receive answers here yet)
        # In real app, we would process request.data['answers']
        final_score = 85.0 
        
        attempt = QuizAttempt.objects.filter(quiz=quiz, user=request.user).last()
        if attempt:
            attempt.score = final_score
            attempt.completed_at = timezone.now()
            attempt.save()
            
        return Response({
            'score': final_score,
            'status': 'completed'
        })

    @action(detail=True, methods=['get'])
    def review(self, request, pk=None):
        """
        GET /api/quizzes/{id}/review/
        """
        quiz = self.get_object()
        # Mock review data
        return Response({
            'user_score': 85,
            'correct_answers': 12,
            'total_questions': 15,
            'status': 'passed'
        })

class NotificationViewSet(viewsets.ModelViewSet):
    serializer_class = NotificationSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Notification.objects.filter(user=self.request.user).order_by('-created_at')

    @action(detail=True, methods=['post'])
    def mark_read(self, request, pk=None):
        notif = self.get_object()
        notif.is_read = True
        notif.save()
        return Response({'status': 'read'})

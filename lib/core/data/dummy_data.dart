import '../models.dart';

class DummyData {
  static final User currentUser = User(
    id: 1,
    username: 'Mahasiswa Celoe',
    email: 'mahasiswa@telkomuniversity.ac.id',
    avatarUrl: 'https://i.pravatar.cc/150?u=u001',
  );

  static final List<Course> courses = [
    Course(
      id: 1,
      title: 'Desain Antarmuka & Pengalaman Pengguna',
      semester: 'Semester 4',
      thumbnail: 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?auto=format&fit=crop&w=800&q=80',
      progress: 85,
    ),
    Course(
      id: 2,
      title: 'Pemrograman Perangkat Bergerak',
      semester: 'Semester 4',
      thumbnail: 'https://images.unsplash.com/photo-1526498460520-4c246339dccb?auto=format&fit=crop&w=800&q=80',
      progress: 45,
    ),
    Course(
      id: 3,
      title: 'Sistem Operasi',
      semester: 'Semester 3',
      thumbnail: 'https://images.unsplash.com/photo-1629654297299-c8506221ca97?auto=format&fit=crop&w=800&q=80',
      progress: 10,
    ),
    Course(
      id: 4,
      title: 'Matematika Diskrit',
      semester: 'Semester 2',
      thumbnail: 'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?auto=format&fit=crop&w=800&q=80',
      progress: 100,
    ),
  ];

  static final List<CourseMaterial> materialsCourse1 = [
    CourseMaterial(
      id: 101,
      title: 'Pengenalan UI/UX',
      description: 'Dasar-dasar perbedaan UI dan UX serta pentingnya dalam pengembangan aplikasi.',
      completed: true,
      attachments: [
        Attachment(id: 1, title: 'Slide Pengenalan', type: 'pdf', url: 'dummy.pdf', completed: true),
        Attachment(id: 2, title: 'Video Materi', type: 'video', url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ', completed: true),
      ],
    ),
    CourseMaterial(
      id: 102,
      title: 'Prinsip Desain Visual',
      description: 'Hierarchy, Contrast, Balance, dan penggunaannya.',
      completed: true,
      attachments: [
        Attachment(id: 3, title: 'Modul 2', type: 'pdf', url: 'dummy.pdf', completed: true),
      ],
    ),
    CourseMaterial(
      id: 103,
      title: 'Wireframing dengan Figma',
      description: 'Tutorial membuat wireframe Lo-Fi.',
      completed: false,
      attachments: [
        Attachment(id: 4, title: 'Tutorial Video', type: 'video', url: 'dummy.mp4', completed: false),
        Attachment(id: 5, title: 'Latihan 1', type: 'link', url: 'https://figma.com', completed: false),
      ],
    ),
  ];

  static final List<Map<String, dynamic>> tasksCourse1 = [
    {
      'id': 201,
      'type': 'assignment',
      'title': 'Tugas 1: Analisis Aplikasi',
      'deadline': '2025-03-10 23:59',
      'status': 'completed', // completed, pending, overdue
      'description': 'Buatlah analisis UI/UX dari aplikasi favorit anda.',
    },
    {
      'id': 202,
      'type': 'quiz',
      'title': 'Kuis 1: Teori Dasar',
      'deadline': '2025-03-15 10:00',
      'status': 'pending',
      'description': 'Kuis pilihan ganda 20 soal.',
    },
    {
      'id': 203,
      'type': 'assignment',
      'title': 'Tugas 2: Redesign Halaman Login',
      'deadline': '2025-03-20 23:59',
      'status': 'pending',
      'description': 'Redesign halaman login LMS ini menjadi lebih modern.',
    },
  ];

  static final List<Map<String, dynamic>> notifications = [
    {
      'id': 1,
      'title': 'Tugas Baru: Redesign Halaman Login',
      'body': 'Dosen Ady Purnomo baru saja menambahkan tugas baru.',
      'date': '2 Jam yang lalu',
      'isRead': false,
    },
    {
      'id': 2,
      'title': 'Nilai Kuis 1 Keluar',
      'body': 'Anda mendapatkan nilai 85 pada Kuis Teori Dasar.',
      'date': '1 Hari yang lalu',
      'isRead': true,
    },
    {
      'id': 3,
      'title': 'Pengumuman Libur',
      'body': 'Perkuliahan ditiadakan pada tanggal merah.',
      'date': '3 Hari yang lalu',
      'isRead': true,
    },
  ];
}

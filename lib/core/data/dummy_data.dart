import '../models.dart';

class DummyData {
  static final UserModel currentUser = UserModel(
    id: 1,
    username: 'Mahasiswa Celoe',
    email: 'mahasiswa@telkomuniversity.ac.id',
    avatarUrl: 'https://i.pravatar.cc/150?u=u001',
    firstName: 'Mahasiswa',
    lastName: 'Celoe',
    country: 'Indonesia',
    description: 'Mahasiswa aktif Telkom University yang semangat belajar.',
    faculty: 'Fakultas Ilmu Terapan',
    studyProgram: 'D3 Sistem Informasi',
    firstAccess: DateTime(2023, 9, 1, 8, 0),
    lastAccess: DateTime.now(),
  );

  static final List<Course> courses = [
    Course(
      id: 1,
      title: 'Desain Antarmuka & Pengalaman Pengguna',
      semester: 'Program Unggulan',
      thumbnail: 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?auto=format&fit=crop&w=800&q=80',
      progress: 85,
      description: 'Program intensif ini dirancang untuk membekali peserta dengan keterampilan praktis dalam merancang antarmuka pengguna yang intuitif dan pengalaman pengguna yang memikat. Meliputi teori dasar desain visual, psikologi pengguna, prototyping dengan Figma, hingga usability testing.\n\nCocok untuk pemula maupun desainer grafis yang ingin beralih ke UI/UX.',
      instructor: 'Tim Desain Telkom University',
      category: 'Workshop Kreatif',
    ),
    Course(
      id: 2,
      title: 'Pemrograman Perangkat Bergerak',
      semester: 'Sertifikasi',
      thumbnail: 'https://images.unsplash.com/photo-1526498460520-4c246339dccb?auto=format&fit=crop&w=800&q=80',
      progress: 45,
      description: 'Pelajari cara membangun aplikasi mobile tangguh untuk Android dan iOS menggunakan Flutter. Program ini mencakup dasar-dasar Dart, widget layout, manajemen state, hingga integrasi API dan database lokal.',
      instructor: 'Lab Mobile Development',
      category: 'Teknologi',
    ),
    Course(
      id: 3,
      title: 'Literasi Digital untuk UMKM',
      semester: 'Pengabdian',
      thumbnail: 'https://images.unsplash.com/photo-1556761175-5973dc0f32e7?auto=format&fit=crop&w=800&q=80',
      progress: 10,
      description: 'Program ini bertujuan membantu pelaku UMKM memahami penggunaan teknologi digital untuk pemasaran dan manajemen usaha. Materi mencakup penggunaan media sosial, e-commerce, dan aplikasi keuangan sederhana.',
      instructor: 'LSM Celoe Community',
      category: 'Sosial',
    ),
    Course(
      id: 4,
      title: 'Bootcamp Data Science Dasar',
      semester: 'Bootcamp',
      thumbnail: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?auto=format&fit=crop&w=800&q=80',
      progress: 0,
      description: 'Memulai perjalanan karir di bidang data dengan mempelajari Python dasar, manipulasi data dengan Pandas, dan visualisasi data. Tidak diperlukan latar belakang coding sebelumnya.',
      instructor: 'Data Science Center',
      category: 'Bootcamp',
    ),
    Course(
      id: 5,
      title: 'Algoritma Pemrograman',
      semester: 'Semester 1',
      thumbnail: 'https://images.unsplash.com/photo-1516116216624-53e697fedbea?auto=format&fit=crop&w=800&q=80',
      progress: 75,
    ),
    Course(
       id: 6,
       title: 'Basis Data',
       semester: 'Semester 3',
       thumbnail: 'https://images.unsplash.com/photo-1544383835-bda2bc66a55d?auto=format&fit=crop&w=800&q=80',
       progress: 30,
    ),
    Course(
       id: 7,
       title: 'Kecerdasan Buatan',
       semester: 'Semester 5',
       thumbnail: 'https://images.unsplash.com/photo-1555255707-c07966088b7b?auto=format&fit=crop&w=800&q=80',
       progress: 60,
    ),
    Course(
       id: 8,
       title: 'Internet of Things (IoT)',
       semester: 'Semester 6',
       thumbnail: 'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
       progress: 10,
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

  static final List<ClassModel> classes = [
    ClassModel(
      id: '1',
      namaKelas: 'Desain Antarmuka & Pengalaman Pengguna',
      kodeKelas: 'UIUX-101',
      dosen: 'Ady Purnomo',
      tanggalMulai: DateTime(2023, 9, 1),
    ),
    ClassModel(
      id: '2',
      namaKelas: 'Pemrograman Perangkat Bergerak',
      kodeKelas: 'MOBILE-201',
      dosen: 'Budi Santoso',
      tanggalMulai: DateTime(2023, 9, 1),
    ),
    ClassModel(
      id: '3',
      namaKelas: 'Sistem Operasi',
      kodeKelas: 'SO-301',
      dosen: 'Cici Lestari',
      tanggalMulai: DateTime(2023, 9, 1),
    ),
  ];
}

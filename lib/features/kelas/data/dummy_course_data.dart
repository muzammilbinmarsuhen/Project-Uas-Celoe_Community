

enum TaskType { quiz, assignment }

class MaterialItem {
  final String id;
  final String title;
  final String meetingTitle;
  final String subtitle;
  final bool isCompleted;
  final String description;
  final List<AttachmentItem> attachments;

  MaterialItem({
    required this.id,
    required this.title,
    required this.meetingTitle,
    required this.subtitle,
    this.isCompleted = false,
    this.description = 'Pelajari materi dasar tentang prinsip-prinsip desain antarmuka pengguna, termasuk layout, typografi, dan penggunaan warna yang efektif dalam aplikasi mobile.',
    this.attachments = const [],
  });
}

class AttachmentItem {
  final String title;
  final String type; // 'pdf', 'video', 'link'
  final String url;

  AttachmentItem({required this.title, required this.type, required this.url});
}

class TaskItem {
  final String id;
  final String title;
  final TaskType type;
  final DateTime deadline;
  final bool isCompleted;
  final String instruction;

  TaskItem({
    required this.id,
    required this.title,
    required this.type,
    required this.deadline,
    this.isCompleted = false,
    this.instruction = 'Kerjakan soal berikut dengan teliti. Pastikan membaca petunjuk pengerjaan sebelum memulai.',
  });
}


class QuizOption {
  final String id;
  final String text;
  final bool isCorrect;

  QuizOption({required this.id, required this.text, this.isCorrect = false});
}

class QuizQuestion {
  final String id;
  final String text;
  final List<QuizOption> options;

  QuizQuestion({required this.id, required this.text, required this.options});
}

class DummyCourseData {
  static final List<MaterialItem> materials = [
    MaterialItem(
      id: '1',
      meetingTitle: 'Pertemuan 1',
      title: '01 - Pengantar User Interface Design',
      subtitle: '3 URLs, 5 Files, 3 Interactive Content',
      isCompleted: true,
      attachments: [
        AttachmentItem(title: 'Panduan Praktikum', type: 'doc', url: 'https://filesamples.com/samples/document/doc/sample2.doc'),
        AttachmentItem(title: 'Slide Presentasi - Animasi', type: 'ppt', url: 'https://filesamples.com/samples/document/ppt/sample1.ppt'),
        AttachmentItem(title: 'Modul Pembelajaran', type: 'pdf', url: 'https://pdfobject.com/pdf/sample.pdf'),
        AttachmentItem(title: 'Rekaman Zoom Meeting', type: 'video', url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
        AttachmentItem(title: 'Referensi Artikel', type: 'link', url: 'https://en.wikipedia.org/wiki/User_interface_design'),
        AttachmentItem(title: 'Video Referensi YouTube', type: 'youtube', url: 'https://www.youtube.com/watch?v=MQ59TV2D5xU'),
      ],
    ),
    MaterialItem(
      id: '2',
      meetingTitle: 'Pertemuan 2',
      title: '02 - Prinsip Layout & Komposisi',
      subtitle: '2 URLs, 1 File',
      isCompleted: false,
      attachments: [
        AttachmentItem(title: 'Modul Bab 2 (PDF)', type: 'pdf', url: '#'),
        AttachmentItem(title: 'Contoh Layout Figma', type: 'link', url: '#'),
      ],
    ),
    MaterialItem(
      id: '3',
      meetingTitle: 'Pertemuan 3',
      title: '03 - Typography & Color Theory',
      subtitle: '4 URLs, 1 File, 1 Quiz',
      isCompleted: false,
    ),
  ];

  static final List<TaskItem> tasks = [
    TaskItem(
      id: 'q1',
      title: 'Quiz Review 01',
      type: TaskType.quiz,
      deadline: DateTime.now().add(const Duration(days: 2)),
      isCompleted: false,
    ),
    TaskItem(
      id: 't1',
      title: 'Tugas 01 - UID Android Mobile Game',
      type: TaskType.assignment,
      deadline: DateTime.now().add(const Duration(days: 5)),
      isCompleted: true,
    ),
  ];

  static final List<QuizQuestion> quizQuestions = [
    QuizQuestion(
      id: '1',
      text: 'Apa tujuan utama dari User Interface (UI) Design?',
      options: [
        QuizOption(id: 'A', text: 'Membuat kode program lebih efisien', isCorrect: false),
        QuizOption(id: 'B', text: 'Meningkatkan estetika tanpa memikirkan fungsi', isCorrect: false),
        QuizOption(id: 'C', text: 'Memfasilitasi interaksi pengguna dengan sistem secara efektif', isCorrect: true),
        QuizOption(id: 'D', text: 'Menyimpan data pengguna di database', isCorrect: false),
        QuizOption(id: 'E', text: 'Membuat animasi yang rumit', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '2',
      text: 'Manakah dari berikut ini yang BUKAN merupakan prinsip dasar desain antarmuka?',
      options: [
        QuizOption(id: 'A', text: 'Konsistensi', isCorrect: false),
        QuizOption(id: 'B', text: 'Umpan Balik (Feedback)', isCorrect: false),
        QuizOption(id: 'C', text: 'Kompleksitas', isCorrect: true),
        QuizOption(id: 'D', text: 'Keterbacaan (Visibility)', isCorrect: false),
        QuizOption(id: 'E', text: 'Efisiensi', isCorrect: false),
      ],
    ),
     QuizQuestion(
      id: '3',
      text: 'Warna manakah yang sering diasosiasikan dengan "Bahaya" atau "Error" dalam desain UI?',
      options: [
        QuizOption(id: 'A', text: 'Hijau', isCorrect: false),
        QuizOption(id: 'B', text: 'Biru', isCorrect: false),
        QuizOption(id: 'C', text: 'Merah', isCorrect: true),
        QuizOption(id: 'D', text: 'Kuning', isCorrect: false),
        QuizOption(id: 'E', text: 'Ungu', isCorrect: false),
      ],
    ),
      QuizQuestion(
      id: '4',
      text: 'Istilah "White Space" dalam desain grafis merujuk pada?',
      options: [
        QuizOption(id: 'A', text: 'Ruang kosong di antara elemen desain', isCorrect: true),
        QuizOption(id: 'B', text: 'Warna latar belakang yang harus selalu putih', isCorrect: false),
        QuizOption(id: 'C', text: 'Area untuk menempatkan logo', isCorrect: false),
        QuizOption(id: 'D', text: 'Garis tepi halaman', isCorrect: false),
        QuizOption(id: 'E', text: 'Ukuran font terkecil', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '5',
      text: 'Apa yang dimaksud dengan "Responsive Design"?',
      options: [
        QuizOption(id: 'A', text: 'Desain yang merespons suara pengguna', isCorrect: false),
        QuizOption(id: 'B', text: 'Desain yang menyesuaikan tampilan dengan ukuran layar perangkat', isCorrect: true),
        QuizOption(id: 'C', text: 'Desain yang memuat gambar dengan cepat', isCorrect: false),
        QuizOption(id: 'D', text: 'Desain yang menggunakan animasi bergerak', isCorrect: false),
        QuizOption(id: 'E', text: 'Desain khusus untuk komputer desktop', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '6',
      text: 'Font jenis apa yang biasanya paling mudah dibaca di layar digital?',
      options: [
        QuizOption(id: 'A', text: 'Serif', isCorrect: false),
        QuizOption(id: 'B', text: 'Sans-Serif', isCorrect: true),
        QuizOption(id: 'C', text: 'Script', isCorrect: false),
        QuizOption(id: 'D', text: 'Decorative', isCorrect: false),
        QuizOption(id: 'E', text: 'Handwriting', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '7',
      text: 'Apa fungsi dari "Wireframe" dalam proses desain?',
      options: [
        QuizOption(id: 'A', text: 'Menentukan palet warna akhir', isCorrect: false),
        QuizOption(id: 'B', text: 'Kerangka dasar struktur halaman/aplikasi', isCorrect: true),
        QuizOption(id: 'C', text: 'Membuat animasi transisi', isCorrect: false),
        QuizOption(id: 'D', text: 'Menulis kode backend', isCorrect: false),
        QuizOption(id: 'E', text: 'Testing performa server', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '8',
      text: 'Ukuran touch target minimal yang disarankan untuk perangkat mobile adalah?',
      options: [
        QuizOption(id: 'A', text: '10x10 px', isCorrect: false),
        QuizOption(id: 'B', text: '24x24 px', isCorrect: false),
        QuizOption(id: 'C', text: '44x44 px (iOS) / 48x48 dp (Android)', isCorrect: true),
        QuizOption(id: 'D', text: '100x100 px', isCorrect: false),
        QuizOption(id: 'E', text: 'Bebas sesuai keinginan', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '9',
      text: 'Pola membaca pengguna pada halaman web yang kaya teks biasanya mengikuti bentuk huruf?',
      options: [
        QuizOption(id: 'A', text: 'Z-Pattern', isCorrect: false),
        QuizOption(id: 'B', text: 'F-Pattern', isCorrect: true),
        QuizOption(id: 'C', text: 'O-Pattern', isCorrect: false),
        QuizOption(id: 'D', text: 'X-Pattern', isCorrect: false),
        QuizOption(id: 'E', text: 'L-Pattern', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '10',
      text: 'Apa kegunaan dari "Breadcrumb" dalam navigasi website?',
      options: [
        QuizOption(id: 'A', text: 'Menampilkan iklan', isCorrect: false),
        QuizOption(id: 'B', text: 'Menunjukkan jejak lokasi halaman saat ini dalam struktur situs', isCorrect: true),
        QuizOption(id: 'C', text: 'Membuat efek animasi remah roti', isCorrect: false),
        QuizOption(id: 'D', text: 'Menghapus history browser', isCorrect: false),
        QuizOption(id: 'E', text: 'Menampilkan footer', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '11',
      text: 'Prinsip Gestalt yang menyatakan bahwa elemen-elemen yang berdekatan dianggap sebagai satu kelompok disebut?',
      options: [
        QuizOption(id: 'A', text: 'Similarity', isCorrect: false),
        QuizOption(id: 'B', text: 'Proximity', isCorrect: true),
        QuizOption(id: 'C', text: 'Closure', isCorrect: false),
        QuizOption(id: 'D', text: 'Continuity', isCorrect: false),
        QuizOption(id: 'E', text: 'Symmetry', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '12',
      text: 'Manakah tool yang populer digunakan untuk UI/UX Design saat ini?',
      options: [
        QuizOption(id: 'A', text: 'Microsoft Excel', isCorrect: false),
        QuizOption(id: 'B', text: 'Figma', isCorrect: true),
        QuizOption(id: 'C', text: 'Notepad', isCorrect: false),
        QuizOption(id: 'D', text: 'Sublime Text', isCorrect: false),
        QuizOption(id: 'E', text: 'Paint', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '13',
      text: 'Apa itu A/B Testing dalam konteks UI/UX?',
      options: [
        QuizOption(id: 'A', text: 'Testing aplikasi di dua device berbeda', isCorrect: false),
        QuizOption(id: 'B', text: 'Membandingkan dua versi desain untuk melihat mana yang lebih efektif', isCorrect: true),
        QuizOption(id: 'C', text: 'Testing dari awal sampai akhir', isCorrect: false),
        QuizOption(id: 'D', text: 'Menguji golongan darah user', isCorrect: false),
        QuizOption(id: 'E', text: 'Testing keamanan server', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '14',
      text: 'Dalam desain formulir, placeholder text sebaiknya tidak digunakan sebagai pengganti?',
      options: [
        QuizOption(id: 'A', text: 'Label', isCorrect: true),
        QuizOption(id: 'B', text: 'Warna Background', isCorrect: false),
        QuizOption(id: 'C', text: 'Border', isCorrect: false),
        QuizOption(id: 'D', text: 'Icon', isCorrect: false),
        QuizOption(id: 'E', text: 'Button', isCorrect: false),
      ],
    ),
    QuizQuestion(
      id: '15',
      text: 'Apa tujuan utama dari "Skeleton Screen" saat loading?',
      options: [
        QuizOption(id: 'A', text: 'Menakuti pengguna', isCorrect: false),
        QuizOption(id: 'B', text: 'Memberikan persepsi performa yang lebih cepat dibanding spinner', isCorrect: true),
        QuizOption(id: 'C', text: 'Menampilkan error', isCorrect: false),
        QuizOption(id: 'D', text: 'Menghemat baterai', isCorrect: false),
        QuizOption(id: 'E', text: 'Menyembunyikan konten selamanya', isCorrect: false),
      ],
    ),
  ];

  // Dummy Slide Data
  static final List<String> slides = [
    'User Interface (UI) adalah titik interaksi antara pengguna dan perangkat digital atau komputer.',
    'Tujuan utama UI adalah membuat interaksi pengguna seefisien dan sesederhana mungkin (user-friendly).',
    'Komponen UI meliputi elemen input (tombol, text field), navigasi (slider, pagination), dan informasi (tooltips, progress bar).',
    'Konsistensi adalah kunci. Gunakan warna, font, dan elemen desain yang seragam di seluruh aplikasi.',
    'Responsivitas: UI harus terlihat bagus dan berfungsi baik di berbagai ukuran layar dan perangkat.',
    'Accessibility: Desain harus dapat diakses oleh semua orang, termasuk pengguna dengan keterbatasan.',
  ];
  
  // Dummy Related Videos (Curated for High Quality & Motivation)
  static final List<Map<String, String>> relatedVideos = [
     {
        'id': 'YiL3Yd51k6c', // Steve Jobs
        'title': 'The Craft of User Experience',
        'author': 'Apple - Steve Jobs',
        'views': '5.2M views',
        'duration': '15:20',
        'thumb': 'https://img.youtube.com/vi/YiL3Yd51k6c/0.jpg'
     },
     {
        'id': '6pD5JuqCQ5c', // Don Norman
        'title': 'The 3 Ways Good Design Makes You Happy',
        'author': 'Don Norman (TED)',
        'views': '2.1M views',
        'duration': '12:44',
        'thumb': 'https://img.youtube.com/vi/RLRlVquney8/0.jpg' // Using valid ID for thumb if needed or generic
     },
     {
        'id': 'vN38HjM8', 
        'title': 'Pengantar Desain Antarmuka Pengguna',
        'author': 'Universitas Telkom',
        'views': '12K views',
        'duration': '10:05',
        'thumb': 'https://i.ytimg.com/vi/bXq6hW2Ea-s/maxresdefault.jpg' // Generic accessible thumb/placeholder
     },
     {
        'id': 'pt1j1W0C8aE',
        'title': '4 Teori Dasar Desain Antarmuka Pengguna',
        'author': 'Universitas Telkom',
        'views': '8.5K views',
        'duration': '14:20',
        'thumb': 'https://i.ytimg.com/vi/pt1j1W0C8aE/maxresdefault.jpg'
     },
  ];

  static final List<Map<String, String>> aiRecommendations = [
     {
        'id': 'FTl5F_278AQ', // Figma
        'title': 'Tutorial Dasar Figma - UI/UX Design Software',
        'author': 'Figma Indonesia',
        'views': '1.2M views',
        'duration': '45:00',
        'thumb': 'https://img.youtube.com/vi/FTl5F_278AQ/0.jpg'
     },
     {
        'id': '_2LLXnUdUIc',
        'title': 'Motivation: Why You Should Become a UI/UX Designer',
        'author': 'DesignCourse',
        'views': '500K views',
        'duration': '08:30',
        'thumb': 'https://img.youtube.com/vi/_2LLXnUdUIc/0.jpg'
     },
  ];
}

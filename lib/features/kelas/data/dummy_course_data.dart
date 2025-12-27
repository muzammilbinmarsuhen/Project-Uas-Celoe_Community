

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
      subtitle: '3 URLs, 2 Files, 3 Interactive Content',
      isCompleted: true,
      attachments: [
        AttachmentItem(title: 'Slide Presentasi PDF', type: 'pdf', url: '#'),
        AttachmentItem(title: 'Rekaman Zoom Meeting', type: 'video', url: '#'),
        AttachmentItem(title: 'Referensi Artikel Medium', type: 'link', url: '#'),
      ],
    ),
    MaterialItem(
      id: '2',
      meetingTitle: 'Pertemuan 2',
      title: '02 - Prinsip Layout & Komposisi',
      subtitle: '2 URLs, 1 File',
      isCompleted: false,
      attachments: [
        AttachmentItem(title: 'Modul Bab 2', type: 'pdf', url: '#'),
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
  
  // Dummy Related Videos
  static final List<Map<String, String>> relatedVideos = [
     {'title': 'Prinsip Dasar UX Design', 'duration': '10:05'},
     {'title': 'Tutorial Figma untuk Pemula', 'duration': '14:20'},
     {'title': 'Color Theory dalam UI', 'duration': '08:45'},
  ];
}

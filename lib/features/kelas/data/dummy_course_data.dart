

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
}

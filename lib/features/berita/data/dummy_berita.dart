

class BeritaModel {
  final String id;
  final String title;
  final String content;
  final String author;
  final String date;
  final String imageUrl;
  final String category;

  BeritaModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.category,
  });
}

class DummyBerita {
  static List<BeritaModel> list = [
    BeritaModel(
      id: '1',
      title: 'Workshop Digital Marketing untuk UMKM',
      content: 'LSM CeLOE Community mengadakan workshop digital marketing gratis bagi pelaku UMKM di sekitar kampus...',
      author: 'Admin',
      date: '12 Jan 2024',
      imageUrl: 'https://images.unsplash.com/photo-1552664730-d307ca884978?auto=format&fit=crop&w=800&q=80',
      category: 'Kegiatan',
    ),
    BeritaModel(
      id: '2',
      title: 'Penyaluran Bantuan Banjir',
      content: 'Tim relawan telah menyalurkan bantuan sembako kepada korban banjir di daerah X...',
      author: 'Relawan',
      date: '05 Jan 2024',
      imageUrl: 'https://images.unsplash.com/photo-1469571486292-0ba58a3f068b?auto=format&fit=crop&w=800&q=80',
      category: 'Sosial',
    ),
    BeritaModel(
      id: '3',
      title: 'Tips Menjaga Kesehatan di Musim Hujan',
      content: 'Musim hujan telah tiba. Berikut adalah beberapa tips untuk menjaga kesehatan agar tetap fit...',
      author: 'Dr. A',
      date: '01 Jan 2024',
      imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?auto=format&fit=crop&w=800&q=80',
      category: 'Edukasi',
    ),
  ];
}

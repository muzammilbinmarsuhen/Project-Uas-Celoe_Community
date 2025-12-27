class PengumumanModel {
  final String id;
  final String title;
  final String content;
  final String date;
  final String category;

  PengumumanModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
  });
}

class DummyPengumuman {
  static List<PengumumanModel> list = [
    PengumumanModel(
      id: '1',
      title: 'Pendaftaran Anggota Baru Dibuka',
      content: 'Pendaftaran anggota baru CeLOE Community kini dibuka. Silakan daftar sebelum tanggal 30.',
      date: '10 Jan 2025',
      category: 'Keanggotaan',
    ),
    PengumumanModel(
      id: '2',
      title: 'Perubahan Jadwal Rapat Tahunan',
      content: 'Rapat tahunan yang semula dijadwalkan tanggal 15 diundur menjadi tanggal 20.',
      date: '05 Jan 2025',
      category: 'Internal',
    ),
    PengumumanModel(
      id: '3',
      title: 'Donasi Bencana Alam',
      content: 'Kami membuka donasi untuk korban bencana. Salurkan bantuan anda melalui...',
      date: '01 Jan 2025',
      category: 'Sosial',
    ),
  ];
}

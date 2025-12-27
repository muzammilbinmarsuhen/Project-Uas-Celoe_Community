import 'package:flutter/material.dart';

enum PengaduanStatus { pending, process, completed, rejected }

class PengaduanModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String date;
  final PengaduanStatus status;
  final String? imageUrl;

  PengaduanModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.status,
    this.imageUrl,
  });

  Color get statusColor {
    switch (status) {
      case PengaduanStatus.pending: return Colors.orange;
      case PengaduanStatus.process: return Colors.blue;
      case PengaduanStatus.completed: return Colors.green;
      case PengaduanStatus.rejected: return Colors.red;
    }
  }

  String get statusText {
    switch (status) {
      case PengaduanStatus.pending: return 'Menunggu';
      case PengaduanStatus.process: return 'Diproses';
      case PengaduanStatus.completed: return 'Selesai';
      case PengaduanStatus.rejected: return 'Ditolak';
    }
  }
}

class DummyPengaduan {
  static List<PengaduanModel> list = [
    PengaduanModel(
      id: 'PG-2024001',
      title: 'AC di Ruang A201 Rusak',
      description: 'AC mengeluarkan suara bising dan tidak dingin saaat perkuliahan berlangsung.',
      location: 'Gedung A Ruang 201',
      date: '10 Jan 2024',
      status: PengaduanStatus.pending,
    ),
    PengaduanModel(
      id: 'PG-2023099',
      title: 'Proyektor Redup',
      description: 'Lampu proyektor sudah mau habis, tampilan sangat redup.',
      location: 'Lab Komputer 3',
      date: '28 Dec 2023',
      status: PengaduanStatus.process,
    ),
    PengaduanModel(
      id: 'PG-2023055',
      title: 'Keran Air Toilet Bocor',
      description: 'Air terus mengalir di toilet lantai 2.',
      location: 'Toilet Pria Lt.2',
      date: '15 Dec 2023',
      status: PengaduanStatus.completed,
    ),
  ];
}

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import '../../core/models.dart';
import 'widgets/profil_header_widget.dart';
import 'widgets/profil_tab_bar_widget.dart';
import 'widgets/profil_info_item_widget.dart';
import 'widgets/edit_profil_form_widget.dart';

class ProfilPage extends StatefulWidget {
  final User? user;
  final XFile? initialImage;
  final Function(XFile)? onImageChanged;

  const ProfilPage({
    super.key, 
    this.user,
    this.initialImage,
    this.onImageChanged,
  });

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedFile; // Store the picked file

  final List<Map<String, dynamic>> _kelasItems = [
    {
      'title': 'Desain Antarmuka & Pengalaman Pengguna',
      'code': 'D4SM-42-03 [ADY]',
      'startDate': 'Dimulai 18 Januari 2021',
    },
    {
       'title': 'Pemrograman Aplikasi Mobile',
       'code': 'D4SM-42-03 [PAM]',
       'startDate': 'Dimulai 20 Januari 2021',
    }
  ];

  // State for Avatar (Fallback)
  final String _avatarUrl = 'https://via.placeholder.com/150';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pickedFile = widget.initialImage;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _pickedFile = image;
        });
        
        // Notify Parent
        if (widget.onImageChanged != null) {
          widget.onImageChanged!(image);
        }

        if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Foto Profil Berhasil Diperbarui')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil gambar: $e')),
        );
      }
    }
  }

  void _handleEditAvatar() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ganti Foto Profil',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text('Ambil Foto', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('Pilih dari Galeri', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    const name = 'DANDY CANDRA PRATAMA';
    
    ImageProvider? avatarImage;
    if (_pickedFile != null) {
      if (kIsWeb) {
        avatarImage = NetworkImage(_pickedFile!.path);
      } else {
        avatarImage = FileImage(File(_pickedFile!.path));
      }
    } else {
      avatarImage = NetworkImage(_avatarUrl);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // 1. Header
          ProfilHeaderWidget(
            name: name, 
            avatarUrl: _avatarUrl, // We might need to update ProfilHeaderWidget to accept ImageProvider to support FileImage
            imageProvider: avatarImage, 
            onEditAvatar: _handleEditAvatar,
          ),

          // 2. Tab Bar
          Transform.translate(
            offset: const Offset(0, -25), // Overlap header slightly
            child: ProfilTabBarWidget(controller: _tabController),
          ),

          // 3. Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // TAB 1: ABOUT ME
                _buildAboutMeTab(),

                // TAB 2: KELAS
                _buildKelasTab(),

                // TAB 3: EDIT PROFILE
                const EditProfilFormWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
             BoxShadow(
               color: const Color.fromRGBO(0, 0, 0, 0.05),
               blurRadius: 10,
               offset: const Offset(0, 4),
             ),
          ],
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfilInfoItemWidget(label: 'E-mail Address', value: 'dandycandrapratama@365.telkomuniversity.ac.id'),
            ProfilInfoItemWidget(label: 'Program Studi', value: 'S1 Desain Komunikasi Visual'),
            ProfilInfoItemWidget(label: 'Fakultas', value: 'Fakultas Industri Kreatif'),
            
            SizedBox(height: 16),
            Text('Aktivitas Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 16),
            
            ProfilInfoItemWidget(label: 'First access to site', value: 'Sunday, 16 August 2020, 10:23 AM (183 days 1 hour)'),
            ProfilInfoItemWidget(label: 'Last access to site', value: 'Tuesday, 16 February 2021, 11:25 AM (now)'),
          ],
        ),
      ),
    );
  }

  Widget _buildKelasTab() {
     return ListView.builder(
       padding: const EdgeInsets.all(16),
       itemCount: _kelasItems.length,
       itemBuilder: (context, index) {
         final item = _kelasItems[index];
         return Container(
           margin: const EdgeInsets.only(bottom: 16),
           padding: const EdgeInsets.all(16),
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(12),
             boxShadow: [
               BoxShadow(
                 color: const Color.fromRGBO(0, 0, 0, 0.05),
                 blurRadius: 10,
                 offset: const Offset(0, 4),
               ),
             ],
           ),
           child: Row(
             children: [
               Container(
                 width: 50, height: 50,
                 decoration: BoxDecoration(
                   color: Colors.blue[50],
                   borderRadius: BorderRadius.circular(25),
                 ),
                 child: Icon(Icons.school, color: Colors.blue[700]),
               ),
               const SizedBox(width: 16),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       item['title'],
                       style: GoogleFonts.poppins(
                         fontWeight: FontWeight.bold,
                         fontSize: 14,
                       ),
                     ),
                     const SizedBox(height: 4),
                     Text(item['code'], style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                     const SizedBox(height: 4),
                     Text(item['startDate'], style: GoogleFonts.poppins(color: Colors.orange, fontSize: 12)),
                   ],
                 ),
               ),
             ],
           ),
         );
       },
     );
  }
}

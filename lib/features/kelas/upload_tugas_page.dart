import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadTugasPage extends StatefulWidget {
  const UploadTugasPage({super.key});

  @override
  State<UploadTugasPage> createState() => _UploadTugasPageState();
}

class _UploadTugasPageState extends State<UploadTugasPage> {
  String? _fileName;

  void _pickFile() {
    setState(() {
      _fileName = 'My_Assignment_Solution.pdf';
    });
  }

  void _saveFile() {
    if (_fileName != null) {
      Navigator.pop(context, true); // Return success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih file terlebih dahulu')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Upload Tugas',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickFile,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(
                          color: Colors.grey[300]!,
                          style: BorderStyle.solid, 
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _fileName != null ? Icons.check_circle_outline : Icons.cloud_upload_outlined,
                            size: 60,
                            color: _fileName != null ? Colors.green : Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _fileName ?? 'Ketuk untuk pilih file',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (_fileName == null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Max size: 10MB',
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveFile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA82E2E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Simpan',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

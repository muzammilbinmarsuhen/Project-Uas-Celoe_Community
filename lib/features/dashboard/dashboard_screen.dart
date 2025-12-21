import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  final String username;

  const DashboardScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                decoration: const BoxDecoration(
                  color: Color(0xFFA82E2E), // Matched Primary
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Halo,',
                            style: GoogleFonts.poppins(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            username.toUpperCase(), // Displaying dynamic username
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7F1D1D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'MAHASISWA',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upcoming Tasks
                    Text(
                      'Tugas Yang Akan Datang',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB91C1C),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: -40,
                            right: -40,
                            child: Container(
                              width: 128,
                              height: 128,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(64),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Desain Antarmuka & Pengalaman Pengguna',
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tugas 01 - UID Android Mobile Game',
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Column(
                                children: [
                                  Text(
                                    'Waktu Pengumpulan',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Jumat 26 Februari, 23:59 WIB',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Announcements
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pengumuman Terakhir',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Lihat Semua',
                            style: GoogleFonts.poppins(
                              color: Colors.blue[600],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey[200]!),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Maintenance Pra UAS Semester Genap 2020/2021',
                              style: GoogleFonts.poppins(
                                color: Colors.grey[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            height: 160,
                            width: double.infinity,
                            color: Colors.blue[50],
                            child: const Center(
                              child: Text(
                                'Maintenance Illustration',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Class Progress
                    Text(
                      'Progres Kelas',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Course cards
                    _buildCourseCard(
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDi6-1ES7EdbjYHgcVlL9BADNCCd42LokEnJSHwPKlLM_et8diEuCWl8j3x-7Gru8c02BpZGKkPe9AendbTHZASpX03QdbClh-eJql_ylQljA4YXLIb1LDdx3PIld0OCsGtq39q4TN_ei3UhHwF0QE9vVEDrz6fTqcDBT3UFt1JTMHnaAeshsmFHvWpHSRL2lQOCpum_iGsVcp619M8gmeVumrZSL1y_wHbI-myQIibgKSSrAMuk4BTrLDh5qLl5Mq5ol17LoEvIA',
                      semester: '2021/2',
                      title: 'Desain Antarmuka & Pengalaman Pengguna D4SM-42-03 [ADY]',
                      progress: 0.89,
                      backgroundColor: Colors.yellow[100]!,
                    ),

                    const SizedBox(height: 16),

                    _buildCourseCard(
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB1Rp1j_Ry7xiNxl0yl7sLrzgMJBi0hbYTzPNY_bsLnkIua9WnqgXHTq6rZXTTV2iHIu41azZvXVScmt5XH_U7rCfzyxURmPIZG4W-JcnEk0uS2I-NivxRsW8-EPofEGe6HG3bZ2Wf1Nj7hqciipCHB5IWPAa1yW7FR61ZG1MwF8t4UG0GDeWnztlGCg-_ueNTQOlgqTjRwDumRfPr_-ZaWF9rJp_kScN177R7pMLLA-bscMPPnm3bkRRWGTewusYIQR-f7fZZazA',
                      semester: '2021/2',
                      title: 'Kewarganegaraan D4SM-41-GAB1 [BBO]. JUMAT 2',
                      progress: 0.86,
                      backgroundColor: Colors.red[100]!,
                    ),

                    const SizedBox(height: 16),

                    _buildCourseCard(
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA5SD5zcuYMBkzBAvMH9YNJvp86n-9IpC1itb17R8W55Lg1NZmL0cylAkgjjfeI08VW0jdTCeC5rhptd5A8m6DjpCMyOpdC-vZ_ne9ZBwhbFffNaT-Za1JzGA5wu6MIeYxt9DFCUCHhani_NToPbwqLfSL-lFDoI3vFFxx8t29qZPJkR1E6DDVXUfulVejJpSydk5p6VspDVCvqA_f89FOZN9xiqlLgHRTPRYa23C9xoeLB-yBWQHIc0X9mYgWH_yeJqdwm8RCrJw',
                      semester: '2021/2',
                      title: 'Sistem Operasi D4SM-44-02 [DDS]',
                      progress: 0.90,
                      backgroundColor: Colors.blue[100]!,
                    ),

                    const SizedBox(height: 16),

                    _buildCourseCard(
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAjhRALYRxdH2Fa1_W2_tjPTkzLMjqw0l0BF_7kkLImrugldBTqw_aGOR9WiBPYfPWEcHXbVgzMFVvCfi9eE7H4YIjTKFZ7_C2U6_57TPtuwHjx5BIZQC_E9vwzbXirGjHCBSYGz2M5hNNmAWLAG5o-mTpYtvAY4XFj_k2bgLZgjVhnvmzhjnqhBayRgze4ptz14R4sSb-bUPj7-5oFta-VEXEELHiXQbF04LtRq4ywX0WmtosTCKSYBkla-RZB-DEXYCwyqBo05Q',
                      semester: '2021/2',
                      title: 'Pemrograman Perangkat Bergerak Multimedia',
                      progress: 0.90,
                      backgroundColor: Colors.teal[100]!,
                    ),

                    const SizedBox(height: 16),

                    _buildCourseCard(
                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDm0ItKTm0TGsp_UydY78XMWFd6VSD9jIuh_JCjeipjiG8U73ipxitFcllzzwE7Dq9DwZC1OlnE1e4NTEjC23_toR-apxiBPv88VdnjEiKtQRANyGIa0_fS5MOWvLsJIM3nQFbvtUGT2vLNBXIpxwCFeZGDaE4ZTxeIIM7llXECP07mXfH6JiOyEkFwB2CToALmvs8cG5kkJQRRaaGnTZCkMwvzz85jipkwnY76IlAIJABP9KP1iM-1kNPSHa1-LbCxDWXMHTawXw',
                      semester: '2021/2',
                      title: 'Bahasa Inggris: Business and Scientific',
                      progress: 0.90,
                      backgroundColor: Colors.grey[100]!,
                    ),

                    const SizedBox(height: 80), // Space for bottom nav
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard({
    required String imageUrl,
    required String semester,
    required String title,
    required double progress,
    required Color backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.book,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  semester,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF991B1B),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${(progress * 100).toInt()} % Selesai',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduate_project/feature/profile/logic/profileCubit.dart';
import 'package:graduate_project/feature/profile/logic/stateCubit.dart';
import 'package:graduate_project/feature/profile/personal_info/personalScreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..fetchUserData(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                final user = state.user;

                return Column(
                  children: [
                    // ================== Blue Header ==================
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/images/omar.png', // حط صورتك هنا
                                  height: 80,
                                ),
                              ),
                              const CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.edit,
                                    size: 16, color: Colors.blue),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(user.fullName,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(user.email,
                              style: const TextStyle(color: Colors.white70)),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    // ================== Tab (Appointment / Medical) ==================
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F6FA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {}, // أكشن لما تضغط
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text("My Appointment",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {}, // أكشن لما تضغط
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  alignment: Alignment.center,
                                  child: Text("Medical records",
                                      style:
                                          TextStyle(color: Colors.grey[600])),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ================== Options List ==================
                    Expanded(
                      child: ListView(
                        children: [
                          _buildItem(
                            Icons.person_outline,
                            "Personal Information",
                            Colors.blue,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileScreen(),
                                ),
                              );
                            },
                          ),
                          _buildItem(Icons.medical_services_outlined,
                              "My Test & Diagnostic", Colors.green),
                          _buildItem(
                              Icons.payment_outlined, "Payment", Colors.red),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is ProfileError) {
                return Center(child: Text("Error: ${state.message}"));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String title, Color iconColor,
      {void Function()? onTap}) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}

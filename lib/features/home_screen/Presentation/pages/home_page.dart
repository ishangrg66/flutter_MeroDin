import 'package:flutter/material.dart';
import 'package:mero_din_app/features/auth/presentation/pages/login_screen.dart';
import 'package:mero_din_app/features/auth/presentation/pages/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 90, 143, 208),
              Color.fromARGB(255, 79, 79, 123),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // App Title and Logo
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ), // more breathing space at the top
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 90, 143, 208),
                              Color.fromARGB(255, 79, 79, 123),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(
                                255,
                                0,
                                0,
                                0,
                              ).withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20), // space around logo
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/logos/meroDinLogo.png',
                            height: MediaQuery.of(context).size.height * 0.16,
                            width: MediaQuery.of(context).size.width * 0.35,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            colorBlendMode: BlendMode.srcOver,
                            color: Colors.white.withOpacity(
                              0.02,
                            ), // subtle overlay for shine
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      const SizedBox(height: 15),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(255, 255, 255, 255),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          "Mero Din",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 38,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      Text(
                        "Organize your day, meetings & events\nall in one smart place.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(
                            0.85,
                          ), // slightly brighter for clarity
                          fontSize: 17, // a bit larger for readability
                          height: 1.6, // more relaxed line spacing
                          fontWeight: FontWeight.w500, // subtle emphasis
                          letterSpacing: 0.3, // smoother flow between letters
                        ),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),

                  // Features Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _featureCard(
                        icon: Icons.event_note_rounded,
                        title: "Schedule Events",
                        description:
                            "Add and manage your daily, weekly, and monthly events with reminders.",
                        // optional accent color
                      ),
                      const SizedBox(height: 14),
                      _featureCard(
                        icon: Icons.people_alt_rounded,
                        title: "Plan Meetings",
                        description:
                            "Create and track meetings with notifications and location details.",
                      ),
                      const SizedBox(height: 14),
                      _featureCard(
                        icon: Icons.task_alt_rounded,
                        title: "To-Do & Notes",
                        description:
                            "Keep short notes or to-do lists to stay productive throughout the day.",
                      ),
                    ],
                  ),

                  // Action Buttons
                  Column(
                    children: [
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignUpPage(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Your day, your way — with Mero Din 🌞",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white30),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

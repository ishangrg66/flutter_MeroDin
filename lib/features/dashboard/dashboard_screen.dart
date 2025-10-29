import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/core/widgets/no_internet_widget.dart';
import 'package:mero_din_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mero_din_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:mero_din_app/features/auth/presentation/pages/login_screen.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_event.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_state.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/pages/current_team_info.dart';
import 'package:mero_din_app/features/profile/presentation/bloc/current_user_bloc.dart';
import 'package:mero_din_app/features/profile/presentation/bloc/current_user_event.dart';
import 'package:mero_din_app/features/profile/presentation/bloc/current_user_state.dart';
import 'package:mero_din_app/features/schedule/presentation/pages/schedule_page.dart';
import 'package:mero_din_app/features/teamInfo/presentation/bloc/team_info_state.dart';
import 'package:nepali_utils/nepali_utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late String _nepaliDateTime = '';
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    context.read<CurrentTeamInfoBloc>().add(LoadCurrentTeamInfo());
    context.read<CurrentUserBloc>().add(LoadCurrentUser());
    _updateNepaliDateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateNepaliDateTime();
    });
  }

  void _updateNepaliDateTime() {
    final now = DateTime.now();
    final nepaliNow = NepaliDateTime.fromDateTime(now);

    final month = _getNepaliMonthName(nepaliNow.month);
    final day = nepaliNow.day;
    final hour = nepaliNow.hour % 12 == 0 ? 12 : nepaliNow.hour % 12;
    final minute = nepaliNow.minute.toString().padLeft(2, '0');
    final period = nepaliNow.hour >= 12 ? 'PM' : 'AM';

    setState(() {
      _nepaliDateTime = "$month $day, $hour:$minute $period";
    });
  }

  String _getNepaliMonthName(int month) {
    switch (month) {
      case 1:
        return "Baisakh";
      case 2:
        return "Jestha";
      case 3:
        return "Ashadh";
      case 4:
        return "Shrawan";
      case 5:
        return "Bhadra";
      case 6:
        return "Ashwin";
      case 7:
        return "Kartik";
      case 8:
        return "Mangsir";
      case 9:
        return "Poush";
      case 10:
        return "Magh";
      case 11:
        return "Falgun";
      case 12:
        return "Chaitra";
      default:
        return "";
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CurrentTeamInfoBloc>().add(LoadCurrentTeamInfo());
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: CustomScrollView(
          slivers: [
            // Gradient Header
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              expandedHeight: 200,
              backgroundColor: const Color.fromARGB(255, 157, 183, 97),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(197, 117, 88, 0.612),
                        Color.fromARGB(240, 85, 63, 61),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 90, left: 25, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "तपाईलाई स्वागत छ ",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      BlocBuilder<CurrentUserBloc, CurrentUserState>(
                        builder: (context, state) {
                          if (state is CurrentUserLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is CurrentUserLoaded) {
                            final userData = state.userEntity;
                            return Text(
                              userData.fullName,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            );
                          } else if (state is CurrentUserNoInternet) {
                            return const NoInternetWidget();
                          } else if (state is CurrentUserError) {
                            return Center(child: Text(state.message));
                          }
                          return const Center(
                            child: Text("Press button to load Users"),
                          );
                        },
                      ),

                      const SizedBox(height: 10),
                      Text(
                        _nepaliDateTime,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout_outlined, color: Colors.white),
                  onPressed: _showLogoutDialog,
                ),
              ],
            ),

            // Main content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Create Team Button
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     addTeamInfoBottomSheet(context, null, (name, code) {
                    //       final data = TeamInfoEntity(
                    //         teamInfoId: 0,
                    //         teamInfoName: name,
                    //         teamInfoCode: code,
                    //         teamInfoimage: code,
                    //         updateKey: "",
                    //         recordStatus: 1,
                    //       );
                    //       context.read<TeamInfoBloc>().add(AddTeamInfo(data));
                    //     });
                    //   },
                    //   icon: const Icon(Icons.add_circle_outline_rounded),
                    //   label: const Text("Create New Team"),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.green.shade600,
                    //     minimumSize: const Size(double.infinity, 48),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     elevation: 3,
                    //   ),
                    // ),
                    // const SizedBox(height: 24),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const AddTeamMemberPage(),
                    //       ),
                    //     );
                    //   },
                    //   icon: const Icon(Icons.person_add_alt_1),
                    //   label: const Text("Add New Member"),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.blue.shade600,
                    //     minimumSize: const Size(double.infinity, 48),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(12),
                    //     ),
                    //     elevation: 3,
                    //   ),
                    // ),
                    // const SizedBox(height: 24),
                    // // Teams section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Teams",
                          style: TextStyle(
                            fontSize: 20,
                            height: 2,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CurrentTeamInfoScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.groups_2_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),

                    // Team list
                    BlocBuilder<CurrentTeamInfoBloc, CurrentTeamInfoState>(
                      builder: (context, state) {
                        if (state is TeamInfoLoading) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (state is CurrentTeamInfoLoaded) {
                          final teams = state.teamInfo;

                          if (teams.isEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Column(
                                children: [
                                  // Image.asset(
                                  //   'assets/images/no_team.png',
                                  //   height: 150,
                                  // ),
                                  // const SizedBox(height: 16),
                                  const Text(
                                    "No teams yet",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: teams.length,
                            itemBuilder: (context, index) {
                              final team = teams[index];
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 4,
                                  shadowColor: Colors.green.withAlpha(50),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SchedulePage(),
                                        ),
                                      );
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 14,
                                    ),
                                    leading: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.green.shade100
                                          .withAlpha(100),
                                      child: const Icon(
                                        Icons.group,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                    ),
                                    title: Text(
                                      team.teamName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Code: ${team.teamCode}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    trailing: IntrinsicWidth(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Active status with icon and text
                                          if (team.statusName.toLowerCase() ==
                                              'active') ...[
                                            const Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 4),
                                            const Text(
                                              'Active',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ] else
                                            Text(
                                              team.statusName,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is CurrentTeamInfoNoInternet) {
                          return const NoInternetWidget();
                        } else if (state is CurrentTeamInfoError) {
                          return Center(child: Text(state.message));
                        }
                        return const Center(child: Text("Loading..."));
                      },
                    ),
                    // const SizedBox(height: 32),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => SchedulePage(),
                    //         ),
                    //       );
                    //     },
                    //     child: Text(
                    //       "View Schedule",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade100),
                      ),
                      child: const Text(
                        "💡 Tip: Stay organized by creating a team for each project or event!",
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: const [
              Icon(Icons.exit_to_app_rounded, color: Colors.redAccent),
              SizedBox(width: 8),
              Text("Sign Out"),
            ],
          ),
          content: const Text(
            "Are you sure you want to sign out?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Sign Out"),
            ),
          ],
        );
      },
    );

    if (!mounted) return;
    if (shouldLogout == true) {
      context.read<AuthBloc>().add(LogoutEvent());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
}

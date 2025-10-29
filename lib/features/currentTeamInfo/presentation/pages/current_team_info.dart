import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_event.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_state.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/pages/team_member_detail.dart';
import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';
import 'package:mero_din_app/features/teamInfo/presentation/bloc/team_info_bloc.dart';
import 'package:mero_din_app/features/teamInfo/presentation/bloc/team_info_event.dart';
import 'package:mero_din_app/features/teamInfo/presentation/widgets/team_info_group.dart';

import '../../../../core/widgets/no_internet_widget.dart';

class CurrentTeamInfoScreen extends StatefulWidget {
  const CurrentTeamInfoScreen({super.key});

  @override
  State<CurrentTeamInfoScreen> createState() => _CurrentTeamInfoScreenState();
}

class _CurrentTeamInfoScreenState extends State<CurrentTeamInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    context.read<CurrentTeamInfoBloc>().add(LoadCurrentTeamInfo());
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 145, 137, 137),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade700, Colors.teal.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Team Info",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.6,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              addTeamInfoBottomSheet(context, null, (name, code) {
                final data = TeamInfoEntity(
                  teamInfoId: 0,
                  teamInfoName: name,
                  teamInfoCode: code,
                  teamInfoimage: code,
                  updateKey: "",
                  recordStatus: 1,
                );
                context.read<TeamInfoBloc>().add(AddTeamInfo(data));
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),

      // 🌟 Glowing FloatingActionButton
      // floatingActionButton: ScaleTransition(
      //   scale: Tween(begin: 0.95, end: 1.05).animate(
      //     CurvedAnimation(parent: _fabController, curve: Curves.easeInOut),
      //   ),
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.green.shade700,
      //     onPressed: () {
      //       // addTeamInfoBottomSheet(context, null, (name, code) {
      //       //   final data = TeamInfoEntity(
      //       //     teamInfoId: 0,
      //       //     teamInfoName: name,
      //       //     teamInfoCode: code,
      //       //     teamInfoimage: code,
      //       //     updateKey: "",
      //       //     recordStatus: 1,
      //       //   );
      //       //   context.read<TeamInfoBloc>().add(AddTeamInfo(data));
      //       // });
      //     },
      //     child: const Icon(Icons.add, color: Colors.white, size: 30),
      //   ),
      // ),
      body: BlocConsumer<CurrentTeamInfoBloc, CurrentTeamInfoState>(
        listener: (context, state) {
          if (state is CurrentTeamInfoSuccess) {
            context.read<CurrentTeamInfoBloc>().add(LoadCurrentTeamInfo());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Team Info added successfully!"),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CurrentTeamInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CurrentTeamInfoLoaded) {
            final teams = state.teamInfo;

            if (teams.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.group_outlined,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "No Teams Yet",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Tap the + button to create your first team!",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.green.shade50.withOpacity(0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          252,
                          252,
                          252,
                        ).withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(18),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.green.shade600,
                      child: const Icon(
                        Icons.groups,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        team.teamName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      "Code: ${team.teamCode}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 114, 113, 113),
                      ),
                    ),

                    trailing: IntrinsicWidth(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Active status with icon and text (no container)
                          if (team.statusName.toLowerCase() == 'active') ...[
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Active',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ] else
                            Flexible(
                              child: Text(
                                team.statusName,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(137, 0, 0, 0),
                                ),
                              ),
                            ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TeamMemberDetailPage(teamMember: team),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color.fromARGB(255, 113, 113, 113),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          if (state is CurrentTeamInfoNoInternet) {
            return const NoInternetWidget();
          }

          if (state is CurrentTeamInfoError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}

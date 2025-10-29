import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';
import 'package:mero_din_app/features/teamInfo/presentation/bloc/team_info_bloc.dart';
import 'package:mero_din_app/features/teamInfo/presentation/widgets/team_info_group.dart';
import '../../../../core/widgets/no_internet_widget.dart';
import '../bloc/team_info_event.dart';
import '../bloc/team_info_state.dart';

class TeamInfoScreen extends StatefulWidget {
  const TeamInfoScreen({super.key});

  @override
  State<TeamInfoScreen> createState() => _TeamInfoScreenState();
}

class _TeamInfoScreenState extends State<TeamInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    context.read<TeamInfoBloc>().add(LoadTeamInfo());
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
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
            letterSpacing: 0.5,
          ),
        ),
      ),

      // 🌟 Glowing FloatingActionButton
      floatingActionButton: ScaleTransition(
        scale: Tween(begin: 0.95, end: 1.05).animate(
          CurvedAnimation(parent: _fabController, curve: Curves.easeInOut),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.green.shade700,
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
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),

      body: BlocConsumer<TeamInfoBloc, TeamInfoState>(
        listener: (context, state) {
          if (state is TeamInfoSuccess) {
            context.read<TeamInfoBloc>().add(LoadTeamInfo());
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Team Info added successfully!"),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TeamInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TeamInfoLoaded) {
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
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.green.shade600,
                      child: const Icon(
                        Icons.groups,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    title: Text(
                      team.teamInfoName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      "Code: ${team.teamInfoCode}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                          tooltip: "Edit Team",
                          onPressed: () {
                            addTeamInfoBottomSheet(context, team, (name, code) {
                              final updated = TeamInfoEntity(
                                teamInfoId: team.teamInfoId,
                                teamInfoName: name,
                                teamInfoCode: code,
                                teamInfoimage: team.teamInfoimage,
                                updateKey: team.updateKey,
                                recordStatus: 1,
                              );
                              context.read<TeamInfoBloc>().add(
                                UpdateTeamInfo(updated),
                              );
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          tooltip: "Delete Team",
                          onPressed: () async {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: const Row(
                                  children: [
                                    Icon(Icons.warning, color: Colors.orange),
                                    SizedBox(width: 8),
                                    Text("Confirm Delete"),
                                  ],
                                ),
                                content: const Text(
                                  "Are you sure you want to delete this team?",
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Delete"),
                                  ),
                                ],
                              ),
                            );

                            if (result == true && context.mounted) {
                              context.read<TeamInfoBloc>().add(
                                DeleteTeamInfo(team.teamInfoId),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is TeamInfoNoInternet) {
            return const NoInternetWidget();
          }

          if (state is TeamInfoError) {
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

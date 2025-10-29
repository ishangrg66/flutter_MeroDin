import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/bloc/approve_team_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/bloc/approve_team_event.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/bloc/approve_team_state.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_event.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/pages/member_info_page.dart';

class TeamMemberDetailPage extends StatefulWidget {
  final CurrentTeamInfoEntity teamMember;

  const TeamMemberDetailPage({super.key, required this.teamMember});

  @override
  State<TeamMemberDetailPage> createState() => _TeamMemberDetailPageState();
}

class _TeamMemberDetailPageState extends State<TeamMemberDetailPage> {
  late String _currentStatus;
  late int _currentRecordStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.teamMember.statusName;
    _currentRecordStatus = widget.teamMember.recordStatus;
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
      case 'Active':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
      case 'Inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _performAction(int action, String newStatus, int newRecordStatus) {
    context.read<ApproveTeamBloc>().add(
      ApproveTeamAction(teamId: widget.teamMember.id, action: action),
    );

    setState(() {
      _currentStatus = newStatus;
      _currentRecordStatus = newRecordStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final team = widget.teamMember;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 149, 150, 148),
      appBar: AppBar(
        title: Text(team.teamName),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MembersInfoPage()),
              );
            },
            icon: Icon(Icons.group),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Avatar & Status Badge
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(team.teamImage),
                    onBackgroundImageError: (_, __) {},
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor(_currentStatus),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle, // active icon
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _currentStatus,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Info Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildDetailRow('Team Name', team.teamName),
                      Divider(
                        height: 18,
                        thickness: 0.5,
                        endIndent: 20,
                        indent: 20,
                      ),
                      _buildDetailRow('Team Code', team.teamCode),
                      Divider(
                        height: 18,
                        thickness: 0.5,
                        endIndent: 20,
                        indent: 20,
                      ),
                      _buildDetailRow('User ID', team.userID.toString()),
                      Divider(
                        height: 18,
                        thickness: 0.5,
                        endIndent: 20,
                        indent: 20,
                      ),
                      _buildDetailRow('Role', _roleText(team.role)),
                      Divider(
                        height: 18,
                        thickness: 0.5,
                        endIndent: 20,
                        indent: 20,
                      ),
                      _buildDetailRow(
                        'Record Status',
                        _currentRecordStatus.toString(),
                      ),
                      Divider(
                        height: 18,
                        thickness: 0.5,
                        endIndent: 20,
                        indent: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              BlocConsumer<ApproveTeamBloc, ApproveTeamState>(
                listener: (context, state) {
                  if (state is ApproveTeamSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    context.read<CurrentTeamInfoBloc>().add(
                      LoadCurrentTeamInfo(),
                    );

                    Navigator.pop(context, true);
                  } else if (state is ApproveTeamError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is ApproveTeamLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildActionButtons(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons() {
    List<Widget> buttons = [];

    if (_currentStatus == 'Pending') {
      buttons.add(_actionButton('Approve', Colors.green, 'Active', 1, 1));
      buttons.add(_actionButton('Reject', Colors.red, 'Rejected', -2, -2));
    } else if (_currentStatus == 'Active' || _currentStatus == 'Approved') {
      buttons.add(_actionButton('Delete', Colors.red, 'Inactive', 2, 2));
    } else if (_currentStatus == 'Rejected' || _currentStatus == 'Inactive') {
      buttons.add(_actionButton('Approve', Colors.green, 'Active', 1, 1));
    }

    return buttons;
  }

  Widget _actionButton(
    String label,
    Color color,
    String newStatus,
    int newRecordStatus,
    int action,
  ) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => _performAction(action, newStatus, newRecordStatus),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                Icons.label_important_rounded,
                color: Colors.green,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  String _roleText(int role) {
    switch (role) {
      case 1:
        return 'Super Admin';
      case 2:
        return 'Admin';
      case 3:
        return 'Member';
      default:
        return 'Unknown';
    }
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color.fromARGB(255, 4, 88, 22),
      height: 20, // space above & below the line
      indent: 10, // left padding
      endIndent: 10,
    );
  }
}

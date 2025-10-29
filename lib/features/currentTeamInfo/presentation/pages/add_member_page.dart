import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/entities/current_team_info_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/domain/entities/search_user_entity.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_event.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/current_team/current_team_info_state.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/search_user/search_user_event.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/bloc/search_user/search_user_state.dart';

class AddTeamMemberPage extends StatefulWidget {
  const AddTeamMemberPage({super.key});

  @override
  State<AddTeamMemberPage> createState() => _AddTeamMemberPageState();
}

class _AddTeamMemberPageState extends State<AddTeamMemberPage> {
  final TextEditingController _userIDController = TextEditingController();

  int? _selectedUserId;
  int? _selectedRole;
  int? _selectedTeamInfoID;

  @override
  void initState() {
    super.initState();

    context.read<CurrentTeamInfoBloc>().add(LoadCurrentTeamInfo());
  }

  void _submit() {
    final userID = _selectedUserId;
    final teamInfoID = _selectedTeamInfoID;
    final role = _selectedRole;

    if (userID == null || teamInfoID == null || role == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select all fields')));
      return;
    }

    final CurrentTeamInfoEntity data = CurrentTeamInfoEntity(
      teamInfoID: teamInfoID,
      userID: userID,
      role: role,
      teamName: '11',
      teamCode: '11',
      teamImage: '11',
      statusName: '11',
      updateKey: '11',
      recordStatus: 0,
      id: 0,
    );

    context.read<CurrentTeamInfoBloc>().add(AddCurrentTeamInfo(data));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Team Member')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          // Added SingleChildScrollView
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /// 🔍 Search User by Email
                  BlocBuilder<UserSearchBloc, UserSearchState>(
                    builder: (context, state) {
                      return Autocomplete<SearchUserEntity>(
                        displayStringForOption: (option) => option.email,
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable.empty();
                          }
                          context.read<UserSearchBloc>().add(
                            FetchUserSuggestions(textEditingValue.text),
                          );
                          if (state is UserSearchSuccess) return state.users;
                          return const Iterable.empty();
                        },
                        onSelected: (selectedUser) {
                          _selectedUserId = selectedUser.id;
                          _userIDController.text = selectedUser.email;
                        },
                        fieldViewBuilder:
                            (
                              context,
                              controller,
                              focusNode,
                              onEditingComplete,
                            ) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  labelText: 'Search User by Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.search),
                                ),
                              );
                            },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                  // const Divider(),

                  /// 🏷 Team Dropdown
                  BlocBuilder<CurrentTeamInfoBloc, CurrentTeamInfoState>(
                    builder: (context, state) {
                      if (state is CurrentTeamInfoLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CurrentTeamInfoLoaded) {
                        final teams = state.teamInfo;
                        return DropdownButtonFormField<int>(
                          initialValue: _selectedTeamInfoID,
                          hint: const Text('Select Team'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                          ),
                          items: teams.map((team) {
                            return DropdownMenuItem<int>(
                              value: team.teamInfoID,
                              child: Text(team.teamName),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() {
                            _selectedTeamInfoID = val;
                          }),
                        );
                      } else if (state is CurrentTeamInfoError) {
                        return Text(
                          'Error loading teams: ${state.message}',
                          style: const TextStyle(color: Colors.red),
                        );
                      } else {
                        return const Text('No teams found');
                      }
                    },
                  ),

                  const SizedBox(height: 30),
                  // const Divider(),

                  /// 🎭 Role Dropdown
                  DropdownButtonFormField<int>(
                    initialValue: _selectedRole,
                    hint: const Text('Select Role'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 1, child: Text('Super Admin')),
                      DropdownMenuItem(value: 2, child: Text('Admin')),
                      DropdownMenuItem(value: 3, child: Text('Member')),
                    ],
                    onChanged: (val) => setState(() => _selectedRole = val),
                  ),

                  const SizedBox(height: 25),

                  /// ✅ Submit Button
                  BlocConsumer<CurrentTeamInfoBloc, CurrentTeamInfoState>(
                    listener: (context, state) {
                      if (state is CurrentTeamInfoSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User added successfully'),
                          ),
                        );
                        _userIDController.clear();
                        setState(() {
                          _selectedUserId = null;
                          _selectedRole = null;
                          _selectedTeamInfoID = null;
                        });
                      } else if (state is CurrentTeamInfoError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: state is CurrentTeamInfoLoading
                            ? null
                            : _submit,
                        child: state is CurrentTeamInfoLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Add Member',
                                style: TextStyle(fontSize: 16),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/core/widgets/no_internet_widget.dart';
import 'package:mero_din_app/features/profile/presentation/bloc/current_user_event.dart';

import '../bloc/current_user_bloc.dart';
import '../bloc/current_user_state.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String getUserRole(int id) {
    switch (id) {
      case 1:
        return "Super Admin";
      case 2:
        return "Admin";
      case 3:
        return "Waiter";
      default:
        return "Unknown";
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<CurrentUserBloc>().add(LoadCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("User Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
          if (state is CurrentUserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrentUserLoaded) {
            final userData = state.userEntity;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade300,
                    child: Text(
                      userData.firstName[0].toUpperCase(),
                      style: const TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userData.fullName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userData.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 24),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          profileTile("Username", userData.username),
                          const Divider(),
                          profileTile("First Name", userData.firstName),
                          const Divider(),
                          profileTile("Last Name", userData.lastName),
                          const Divider(),
                          profileTile(
                            "User Group",
                            getUserRole(userData.userGroupId),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CurrentUserNoInternet) {
            return const NoInternetWidget();
          } else if (state is CurrentUserError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Press button to load Users"));
        },
      ),
    );
  }

  Widget profileTile(String title, String value) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      leading: const Icon(Icons.person, color: Colors.blue),
    );
  }
}

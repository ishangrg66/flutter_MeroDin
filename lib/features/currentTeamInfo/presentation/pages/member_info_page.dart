import 'package:flutter/material.dart';
import 'package:mero_din_app/features/currentTeamInfo/presentation/pages/add_member_page.dart';

class MembersInfoPage extends StatefulWidget {
  const MembersInfoPage({super.key});

  @override
  State<MembersInfoPage> createState() => _MembersInfoPageState();
}

class _MembersInfoPageState extends State<MembersInfoPage> {
  // Static data for now
  final List<Map<String, String>> members = [
    // {'name': 'Prabesh Bhattarai', 'role': 'Admin'},
    // {'name': 'Sita Sharma', 'role': 'Member'},
    // {'name': 'Ram Gurung', 'role': 'Member'},
    // {'name': 'Nabin Shrestha', 'role': 'Moderator'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTeamMemberPage(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: members.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final member = members[index];
          return ListTile(
            leading: CircleAvatar(child: Text(member['name']![0])),
            title: Text(member['name']!),
            subtitle: Text(member['role']!),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  members.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mero_din_app/features/teamInfo/domain/entities/team_info_entities.dart';

void addTeamInfoBottomSheet(
  BuildContext context,
  TeamInfoEntity? teamInfo,
  Function(String name, String code) onSubmit,
) {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(
    text: teamInfo?.teamInfoName ?? "",
  );
  final TextEditingController codeController = TextEditingController(
    text: teamInfo?.teamInfoCode ?? "",
  );

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Bar
                      Center(
                        child: Container(
                          height: 6,
                          width: 60,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // Gradient Header
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade600,
                              Colors.teal.shade400,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              teamInfo == null
                                  ? Icons.group_add
                                  : Icons.edit_note_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              teamInfo == null
                                  ? "Create New Team"
                                  : "Update Team Info",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Team Name Field
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Team Name",
                          prefixIcon: const Icon(Icons.group_outlined),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.green.shade600,
                            ),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Enter team name"
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Team Code Field
                      TextFormField(
                        controller: codeController,
                        decoration: InputDecoration(
                          labelText: "Team Code",
                          prefixIcon: const Icon(Icons.code),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: Colors.green.shade600,
                            ),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Enter team code"
                            : null,
                      ),

                      const SizedBox(height: 24),

                      // Buttons Row
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close_rounded),
                              label: const Text("Cancel"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.grey[700],
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  onSubmit(
                                    nameController.text.trim(),
                                    codeController.text.trim(),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(Icons.check_circle_outline),
                              label: Text(
                                teamInfo == null ? "Add Team" : "Update",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade600,
                                foregroundColor: Colors.white,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

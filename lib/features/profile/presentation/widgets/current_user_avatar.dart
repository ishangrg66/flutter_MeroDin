import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mero_din_app/features/profile/presentation/bloc/current_user_bloc.dart';
import 'package:mero_din_app/features/profile/presentation/bloc/current_user_state.dart';

import '../../../../core/widgets/skeleton_circle.dart';
import '../pages/user_profile.dart';

class CurrentUserAvatar extends StatelessWidget {
  final double radius;

  const CurrentUserAvatar({super.key, this.radius = 16});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfile()),
        );
      },
      child: BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
          if (state is CurrentUserLoading) {
            return SkeletonCircle(radius: radius);
          } else if (state is CurrentUserLoaded) {
            final user = state.userEntity;
            return CircleAvatar(
              radius: radius,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                user.firstName[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return CircleAvatar(
            radius: radius,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.person, color: Colors.white),
          );
        },
      ),
    );
  }
}

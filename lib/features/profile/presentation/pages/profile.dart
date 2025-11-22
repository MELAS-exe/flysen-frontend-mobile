import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flysen_frontend_mobile/app/router/app_router.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
import 'package:flysen_frontend_mobile/core/theme/theme.dart';
import 'package:flysen_frontend_mobile/core/utils/dimensions.dart';
import 'package:flysen_frontend_mobile/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:flysen_frontend_mobile/features/profile/presentation/widgets/profile_card.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: Dimension.aroundPadding,
            child: Column(
              children: [
                ProfileCard(
                    name: "Nazar Amine",
                    totalPoints: 3000,
                    totalFlights: 12,
                    totalReservations: 7,
                    totalPrizes: 5),
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  children: [
                    Text(
                      "Cadeaux disponibles",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                              color:
                                  AppTheme.lightTheme.colorScheme.onSurface,
                              fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1, // To make items square
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1.w, color: Colors.grey),
                          borderRadius: BorderRadius.circular(30)),
                    );
                  },
                ),
                SizedBox(
                  height: 32,
                ),
                CustomButton(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  text: "Se déconnecter",
                  onPressed: () {
                    context.read<AuthBloc>().add(SignOutRequested());
                    context.goNamed(AppRouter.auth);
                  },
                ),
                SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

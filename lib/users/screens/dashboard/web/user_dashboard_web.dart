import 'package:flutter/material.dart';
import 'package:june/june.dart';
import 'package:ssnhi_app/users/screens/dashboard/user_dashboard_appbar.dart';
import 'package:ssnhi_app/users/screens/dashboard/user_dashboard_menu.dart';
import 'package:ssnhi_app/users/screens/dashboard/state/dashboard_state.dart';
import 'package:ssnhi_app/users/screens/dashboard/web/user_dashboard_web_body.dart';

class UserDashboardWebView extends StatelessWidget {
  const UserDashboardWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return JuneBuilder(
      () => DashboardState(),
      builder: (webState) {
        return const Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UserDashboardAppbar(),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // if (!Responsive.isMobile(context))
                    // Expanded(
                    //   flex: Responsive.isTablet(context) ? 3 : 2,
                    //   child:
                    Expanded(child: UserDashboardMenu()),
                    // ),
                    // Expanded(flex: 2, child:
                    Expanded(flex: 5, child: UserDashboardWebBody())
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hormoniousflo/ui/shared/const_colors.dart';


/// Handles all alerts shown to the user
class AppAlert {
  static Future<dynamic> loadingButtomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        // isDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: 90,
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 14),
            color: const Color(0xFFE5E8FF),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(width: 20),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(kBlueColour) ,
                  // b
                ),
                SizedBox(width: 20),
                Text(
                  'Approximating current phase...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: kAppColor,
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<dynamic> errorButtomSheet(
      BuildContext context, String errorText) {
    return showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isDismissible: false,
        barrierColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: 65,
            color: Colors.red,
            child: Row(
              children:  [
                const SizedBox(width: 20),
                const Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                Text(
                  errorText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

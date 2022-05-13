import 'package:flutter/material.dart';
import 'package:hormoniousflo/data/controller/phase_controller.dart';
import 'package:hormoniousflo/ui/shared/app_input.dart';
import 'package:hormoniousflo/ui/shared/const_colors.dart';
import 'package:provider/provider.dart';

class CheckInView extends StatelessWidget {
  const CheckInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Consumer<PhaseController>(
      builder: (context, controller, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              color: kAppColor,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          backgroundColor: Colors.white,
          floatingActionButton: Padding(
            padding: controller.isBottomSheetOpen
                ? const EdgeInsets.only(bottom: 60)
                : const EdgeInsets.all(0),
            child: FloatingActionButton(
              backgroundColor: kAppColor,
              onPressed: () {
                FocusScope.of(context).unfocus();
                controller.getCycleInfo(context);
              },
              child: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(
              bottom: isKeyboardOpen ? 5 : 75,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Image.asset(
                    'assets/images/woman_image.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: isKeyboardOpen
                        ? Colors.white.withOpacity(0.5)
                        : Colors.transparent,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            'What\'s the start date of your last period?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.4,
                              color: kAppColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => controller.selectDate(context),
                            child: AppInput(
                              enabled: false,
                              controller: controller.periodDate != null
                                  ? TextEditingController.fromValue(
                                      TextEditingValue(
                                        text: controller.periodDate!,
                                      ),
                                    )
                                  : null,
                              hintText: 'Last Period',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              'On average, how many days does your period last?',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.4,
                                color: kAppColor,
                              )),
                          const SizedBox(height: 10),
                          AppInput(
                            hintText: 'Length of Period',
                            onChanged: controller.updatePeriodLength,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                              'What\'s the average time between the first days of your periods?',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.4,
                                color: kAppColor,
                              )),
                          const SizedBox(height: 10),
                          AppInput(
                            hintText: 'Length of Cycle',
                            onChanged: controller.updateCycleLength,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

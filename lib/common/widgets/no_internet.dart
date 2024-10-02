import 'package:vendor/common/widgets/buttons.dart';
import 'package:vendor/common/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/utils/strings.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            regularDynamic(Strings().noInternetConnection),
            flatButton('Retry', () {
              Get.back();
            })
          ],
        ),
      ),
    );
  }
}

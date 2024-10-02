
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vendor/common/widgets/texts.dart';
import 'package:vendor/utils/utility.dart';

//21:00 PM | Thursday | 29 August 2024
String toDateFromTimeStamp(int timeStamp, {format}) {
  var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  final DateFormat formatter =
      DateFormat(format ?? 'hh:mm a | EEEE | d MMMM y');
  return formatter.format(date);
}

String addDaysInTimeStamp(int timeStamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  date = date.add(const Duration(days: 2));
  final DateFormat formatter = DateFormat('hh:mm a | EEEE | d MMMM y');
  return formatter.format(date);
}

DateTime toDateTimeFromTimeStamp(timeStamp) {
  return DateTime.fromMillisecondsSinceEpoch(timeStamp);
}

Widget countDownTimer(int durationTimestamp) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(durationTimestamp);
  if (dateTime.isBefore(DateTime.now())) {
    return boldDynamic('Delivery time is over');
  } else {
    return TweenAnimationBuilder<Duration>(
        duration: DateTime.fromMillisecondsSinceEpoch(durationTimestamp)
            .difference(DateTime.now()),
        tween: Tween(
            begin: DateTime.fromMillisecondsSinceEpoch(durationTimestamp)
                .difference(DateTime.now()),
            end: Duration.zero),
        onEnd: () {
          kPrint('Timer ended');
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final days = value.inDays % 24;
          final hours = value.inHours % 24;
          final minutes = value.inMinutes % 60;
          final seconds = value.inSeconds % 60;
          return boldDynamic('${days}d : ${hours}h : ${minutes}m : ${seconds}s',
              textAlign: TextAlign.center, textSize: 17.sp);
        });
  }
}

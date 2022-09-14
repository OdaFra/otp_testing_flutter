import 'package:flutter/material.dart';

import 'package:otp_pincode_input_field/theme/app_theme.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerWatch extends StatefulWidget {
  const TimerWatch({Key? key}) : super(key: key);

  @override
  State<TimerWatch> createState() => _TimerWatchState();
}

class _TimerWatchState extends State<TimerWatch> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(10),
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStop: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );
  @override
  void initState() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: _stopWatchTimer.rawTime.value,
        builder: (context, snap) {
          final value = snap.data!;
          final displayTime = StopWatchTimer.getDisplayTime(value,
              hours: false, milliSecond: false);
          return Column(
            children: <Widget>[
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    color: Color.fromRGBO(83, 46, 83, 1),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    displayTime,
                    style: AppTheme.styles.infoTextRegular14,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text('Tiempo de reenvió',
                      style: AppTheme.styles.infoTextRegular14),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

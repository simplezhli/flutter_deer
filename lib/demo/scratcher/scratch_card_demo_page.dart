
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/colors.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:scratcher/scratcher.dart';

class ScratchCardDemoPage extends StatefulWidget {

  const ScratchCardDemoPage({Key key}) : super(key: key);

  @override
  _ScratchCardDemoPageState createState() => _ScratchCardDemoPageState();
}

class _ScratchCardDemoPageState extends State<ScratchCardDemoPage> {

  final GlobalKey<ScratcherState> scratchKey = GlobalKey<ScratcherState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.isDark ? Colours.dark_bg_color : Colors.blue,
        title: const Text('ScratchCard Demo'),
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap16,
          Scratcher(
            key: scratchKey,
            brushSize: 20,
            threshold: 50,
            color: Colors.grey,
            onChange: (value) => print('Scratch progress: ${value.toStringAsFixed(2)}%'),
            onThreshold: () {
              /// 这里设置刮开50%，就揭开所有。
              print('Threshold reached!');
              scratchKey.currentState.reveal(
                duration: const Duration(milliseconds: 1000),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,
              height: 200,
              width: 300,
              child: const LoadAssetImage('logo',),
            ),
          ),
          Gaps.vGap50,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                child: const Text('Reset'),
                onPressed: () {
                  scratchKey.currentState.reset(
                    duration: const Duration(milliseconds: 2000),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Reveal'),
                onPressed: () {
                  scratchKey.currentState.reveal(
                    duration: const Duration(milliseconds: 2000),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

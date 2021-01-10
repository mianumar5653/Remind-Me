import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:reminder_app/modal/walkThroughScreen/walkThroughScreen.dart';
import 'package:reminder_app/themes.dart';
import 'package:reminder_app/modal/widget/sizeConfig.dart';
import 'package:reminder_app/themes.dart';

class SplashScreen extends StatefulWidget {
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Duration loadDuration;
  final Duration waveDuration;
  final double boxHeight;
  final double boxWidth;
  final String text;
  final Color boxBackgroundColor;
  final Color waveColor;
  final double loadUntil;
  SplashScreen({
    Key key,
    @required this.text,
    this.textStyle =
    const TextStyle(fontSize: 59, fontWeight: FontWeight.w900),
    this.textAlign = TextAlign.left,
    this.loadDuration = const Duration(seconds: 4),
    this.waveDuration = const Duration(seconds: 2),
    this.boxHeight =650,
    this.boxWidth = 0,
    this.boxBackgroundColor,
    this.loadUntil = 1.0, this.waveColor=primaryColor,
  })  : assert(null != text),
        assert(null != textStyle),
        assert(null != textAlign),
        assert(null != loadDuration),
        assert(null != waveDuration),
        assert(null != boxHeight),
        assert(null != boxWidth),
        assert(null != boxBackgroundColor),
        assert(null != waveColor),
        assert(loadUntil > 0 && loadUntil <= 1.0),
        super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _textKey = GlobalKey();
  AnimationController _waveController, _loadController;
  Animation<double> _loadValue;
  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: widget.waveDuration,
    );
    _loadController = AnimationController(
      vsync: this,
      duration: widget.loadDuration,
    );
    _loadValue = Tween<double>(
      begin: 0.0,
      end: widget.loadUntil,
    ).animate(_loadController);
    if (1.0 == widget.loadUntil) {
      _loadValue.addStatusListener((status) {
        if (AnimationStatus.completed == status) {
// Stop the repeating wave when the load has completed to 100%
          _waveController.stop();
          Get.off(WalkThroughScreen());
        }
      });
    }
    _waveController.repeat();
    _loadController.forward();
  }
  @override
  void dispose() {
    _waveController.dispose();
    _loadController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: AnimatedBuilder(
                animation: _waveController,
                builder: (BuildContext context, Widget child) {
                  return CustomPaint(
                    painter: _WavePainter(
                      textKey: _textKey,
                      waveValue: _waveController.value,
                      loadValue: _loadValue.value,
                      boxHeight: widget.boxHeight,
                      waveColor: widget.waveColor,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ShaderMask(
                blendMode: BlendMode.srcOut,
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Get.isDarkMode?darkGreyColor:widget.boxBackgroundColor],
                  stops: [0.0],
                ).createShader(bounds),
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                          widget.text,
                          key: _textKey,
                          style: widget.textStyle,
                          textAlign: widget.textAlign,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class _WavePainter extends CustomPainter {
  static const _pi2 = 2 * pi;
  final GlobalKey textKey;
  final double waveValue;
  final double loadValue;
  final double boxHeight;
  final Color waveColor;
  _WavePainter({
    @required this.textKey,
    this.waveValue,
    this.loadValue,
    this.boxHeight,
    this.waveColor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final RenderBox textBox = textKey.currentContext.findRenderObject();
    final textHeight = textBox.size.height;
    final baseHeight =
        (boxHeight / 2) + (textHeight / 2) - (loadValue * textHeight);
    final width = size.width ?? 200;
    final height = size.height ?? 200;
    final path = Path();
    path.moveTo(0.0, baseHeight);
    for (var i = 0.0; i < width; i++) {
      path.lineTo(i, baseHeight + sin(_pi2 * (i / width + waveValue)) * 8);
    }
    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();
    final wavePaint = Paint()..color = waveColor;
    canvas.drawPath(path, wavePaint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


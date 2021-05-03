import 'package:flutter/material.dart';
import 'package:flutter_deer/demo/lottie/bunny.dart';
import 'package:lottie/lottie.dart';

/// Android版实现：https://github.com/omarsahl/Flopsy
/// 感谢Flopsy项目提供的思路及素材
class LottieDemo extends StatefulWidget {

  const LottieDemo({Key? key,}) : super(key: key);

  @override
  _LottieDemoState createState() => _LottieDemoState();
}

const Color _primaryColor = Color(0xFFFFBCBF);
const Color _backgroundColor = Color(0xFF37474F);
const Color _textColor = Color(0xFFCCCCCC);

class _LottieDemoState extends State<LottieDemo> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Bunny _bunny;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.stop();
    _bunny = Bunny(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 屏幕宽度减去左右各16的padding，计算出输入框宽度。
    final double textFieldWidth = MediaQuery.of(context).size.width - 32;

    final Widget content = Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: _backgroundColor,
        title: const Text('Lottie Demo', style: TextStyle(color: _textColor),),
        iconTheme: const IconThemeData(color: _textColor),
      ),
      backgroundColor: _backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32.0),
            Lottie.asset(
              'assets/lottie/bunny_new_mouth.json',
              width: 250,
              height: 250,
              controller: _controller,
              fit: BoxFit.fill,
              onLoaded: (composition) {
                setState(() {
                  // 计算帧数 composition.endFrame - composition.startFrame;
                  /// 设置动画时长
                  _controller.duration = composition.duration;
                });
              },
            ),
            _MyTextField(
              labelText: 'Email',
              keyboardType: TextInputType.emailAddress,
              onHasFocus: (isObscure) {
                /// 获取焦点，开始文字跟踪状态
                _bunny.setTrackingState();
              },
              onChanged: (text) {
                /// 计算输入文字宽度占输入框宽度的比例
                _bunny.setEyesPosition(_getTextSize(text) / textFieldWidth);
              },
            ),
            _MyTextField(
              labelText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onHasFocus: (isObscure) {
                /// 获取焦点，设置状态
                if (isObscure) {
                  _bunny.setShyState();
                } else {
                  _bunny.setPeekState();
                }
              },
              onObscureText: (isObscure) {
                if (isObscure) {
                  _bunny.setShyState();
                } else {
                  _bunny.setPeekState();
                }
              },
            ),
          ],
        ),
      ),
    );

    return Theme(
      data: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _primaryColor,
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: _primaryColor.withAlpha(70),
          selectionHandleColor: _primaryColor,  // 覆盖`selectionHandleColor`不起作用 https://github.com/flutter/flutter/issues/74890
          cursorColor: _primaryColor,
        ),
      ),
      child: content,
    );
  }

  /// 获取文字宽度
  double _getTextSize(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 16.0,)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}

class _MyTextField extends StatefulWidget {

  const _MyTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.onHasFocus,
    this.onObscureText,
    this.onChanged
  }) : super(key: key);

  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  /// 获取焦点监听
  final Function(bool isObscure)? onHasFocus;
  /// 密码可见监听
  final Function(bool isObscure)? onObscureText;
  /// 文字输入监听
  final Function(String text)? onChanged;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<_MyTextField> {

  bool _isObscure = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_refresh);
  }

  void _refresh() {
    if (_focusNode.hasFocus && widget.onHasFocus != null) {
      widget.onHasFocus?.call(_isObscure);
    }
    setState(() {

    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_refresh);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Listener(
        onPointerDown: (e) => FocusScope.of(context).requestFocus(_focusNode),
        child: TextField(
          focusNode: _focusNode,
          style: const TextStyle(
            color: _textColor,
            fontSize: 16.0,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: _focusNode.hasFocus ? _primaryColor : _textColor,
            ),
            contentPadding: const EdgeInsets.only(left: 8.0),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: _textColor,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: _primaryColor,
              ),
            ),
            suffixIcon: widget.obscureText ? IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: _focusNode.hasFocus ? _primaryColor : _textColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
                if (widget.onObscureText != null) {
                  widget.onObscureText?.call(_isObscure);
                }
              },
            ) : null,
          ),
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ? _isObscure : widget.obscureText,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}


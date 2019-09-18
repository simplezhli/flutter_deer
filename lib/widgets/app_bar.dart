
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{

  const MyAppBar({
    Key key,
    this.backgroundColor: Colors.white,
    this.title: "",
    this.centerTitle: "",
    this.actionName: "",
    this.backImg: "assets/images/ic_back_black.png",
    this.onPressed,
    this.isBack: true
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle _overlayStyle = ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
        ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
                    width: double.infinity,
                    child: Text(
                        title.isEmpty ? centerTitle : title,
                        style: TextStyle(
                          fontSize: Dimens.font_sp18,
                          color: _overlayStyle == SystemUiOverlayStyle.light ? Colors.white : Colours.text_dark,
                        )
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  )
                ],
              ),
              isBack ? IconButton(
                onPressed: (){
                  FocusScope.of(context).unfocus();
                  Navigator.maybePop(context);
                },
                tooltip: 'Back',
                padding: const EdgeInsets.all(12.0),
                icon: Image.asset(
                  backImg,
                  color: _overlayStyle == SystemUiOverlayStyle.light ? Colors.white : Colours.text_dark,
                ),
              ) : Gaps.empty,
              Positioned(
                right: 0.0,
                child: Theme(
                  data: ThemeData(
                      buttonTheme: ButtonThemeData(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        minWidth: 60.0,
                      )
                  ),
                  child: actionName.isEmpty ? Container() :
                  FlatButton(
                    child: Text(actionName, key: const Key('actionName')),
                    textColor: _overlayStyle == SystemUiOverlayStyle.light ? Colors.white : Colours.text_dark,
                    highlightColor: Colors.transparent,
                    onPressed: onPressed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}

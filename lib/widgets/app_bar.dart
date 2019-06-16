
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/resources.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget{

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
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}

class _MyAppBarState extends State<MyAppBar> {

  SystemUiOverlayStyle _overlayStyle = SystemUiOverlayStyle.light;

  @override
  void initState() {
    super.initState();
    setState(() {
      _overlayStyle = ThemeData.estimateBrightnessForColor(widget.backgroundColor) == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark;
    });
  }

  Color getColor(){
    return _overlayStyle == SystemUiOverlayStyle.light ? Colors.white : Colours.text_dark;
  }
  
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: widget.backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: widget.centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
                    width: double.infinity,
                    child: Text(
                      widget.title.isEmpty ? widget.centerTitle : widget.title,
                      style: TextStyle(
                        fontSize: Dimens.font_sp18,
                        color: getColor(),
                      )
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  )
                ],
              ),
              widget.isBack ? IconButton(
                onPressed: (){
                  Navigator.maybePop(context);
                },
                padding: const EdgeInsets.all(12.0),
                icon: Image.asset(
                  widget.backImg,
                  color: getColor(),
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
                  child: widget.actionName.isEmpty ? Container() :
                  FlatButton(
                    child: Text(widget.actionName),
                    textColor: getColor(),
                    highlightColor: Colors.transparent,
                    onPressed: widget.onPressed,
                  ),
                ),
              ),
//            IconButton(
//              icon: Icon(Icons.add),
//              highlightColor: Colors.transparent,
//              onPressed: widget.onPressed,
//            )
            ],
          ),
        ),
      ),
    );
  }
}

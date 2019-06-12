
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/resources.dart';
import 'package:flutter_deer/util/utils.dart';

class StoreSelectTextItem extends StatefulWidget {

  const StoreSelectTextItem({
    Key key,
    this.onTap,
    @required this.title,
    this.content: "",
    this.textAlign: TextAlign.start,
    this.style
  }): super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle style;
  
  @override
  _StoreSelectTextItemState createState() => _StoreSelectTextItemState();
}

class _StoreSelectTextItemState extends State<StoreSelectTextItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(right: 8.0, left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
              bottom: Divider.createBorderSide(context, color: Colours.line, width: 0.6),
            )
        ),
        child: Row(
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyles.textDark14,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                child: Text(
                  widget.content,
                  maxLines: 2,
                  textAlign: widget.textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: widget.style ?? TextStyles.textDark14,
                ),
              ),
            ),
            Image.asset(
              Utils.getImgPath("ic_arrow_right"),
              height: 16.0,
              width: 16.0,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FilterCard extends StatefulWidget {
  String name;
  Function callback;
  FilterCard(this.name,this.callback);
  @override
  _FilterCardState createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  bool chosen = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          chosen = !chosen;
        });
          // print(widget.name.toString());
        widget.callback(widget.name.toString());
      },
      child: Container(
        margin: EdgeInsets.only(right: ScreenUtil().setWidth(8)),
        width: ScreenUtil().setWidth(6*widget.name.length+22),
        height: ScreenUtil().setHeight(20),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: chosen ? Color(0xffffbf2f) :Color(0xffffefcc),),
        child: Center(
          child: Text(widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Color(0xff888888),
                fontSize: ScreenUtil().setSp(12,allowFontScalingSelf: false),
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.normal,
              )),
        ),
      ),
    );
  }
}
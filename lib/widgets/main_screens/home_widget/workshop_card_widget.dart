import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class WorkshopCard extends StatelessWidget {
  String image_source;
  String for_whom;
  String title;
  Timestamp date;
  String speaker;
  final Function redirectWorkshop;
  WorkshopCard(this.image_source, this.for_whom, this.title, this.date,
      this.speaker, this.redirectWorkshop);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          right: ScreenUtil().setWidth(13),
          bottom: ScreenUtil().setHeight(1),
          left: ScreenUtil().setWidth(1)),
      decoration: new BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0x26454545),
            offset: Offset(0, 5),
            blurRadius: 6,
            spreadRadius: 0,
          )
        ],
      ),
      height: ScreenUtil().setHeight(192),
      width: ScreenUtil().setWidth(192),
      child: InkWell(
        onTap: () {
          redirectWorkshop();
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.only(top: 5, right: 5, left: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  // Image.network(image_source,
                  CachedNetworkImage(
                      imageUrl: image_source,
                      // placeholder: (context, url) => Image(
                      //     image: AssetImage('assets/images/top_image.png')),
                      // CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.fill,
                      width: ScreenUtil().setWidth(182),
                      height: ScreenUtil().setHeight(99)),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(170),
            margin: EdgeInsets.only(top: 12, left: 12, right: 5, bottom: 8),
            child: Text(title,
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  color: Color(0xff000000),
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, bottom: 3),
            child: Row(
              children: [
                Container(
                    width: ScreenUtil().setWidth(12),
                    height: ScreenUtil().setHeight(12),
                    margin: EdgeInsets.only(right: 4),
                    child: Image.asset("assets/images/good_for_icon.png")),
                Container(
                  width: ScreenUtil().setWidth(165),
                  child: Text(for_whom,
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        color: Color(0xff000000),
                        fontSize: ScreenUtil().setSp(9),
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      )),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, bottom: 3),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 4),
                    width: ScreenUtil().setWidth(12),
                    height: ScreenUtil().setHeight(12),
                    child: Image.asset("assets/images/speaker_icon.png")),
                Container(
                  width: ScreenUtil().setWidth(165),
                  child:
                    Text(speaker,
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          color: Color(0xff000000),
                          fontSize: ScreenUtil().setSp(9),
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                        )),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 4),
                    width: ScreenUtil().setWidth(12),
                    height: ScreenUtil().setHeight(12),
                    child: Image.asset("assets/images/date_icon.png")),
                Text(DateFormat('MMM dd, y').format(date.toDate()),
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xff000000),
                      fontSize: ScreenUtil().setSp(9),
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

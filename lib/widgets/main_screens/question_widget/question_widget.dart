import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:intl/intl.dart';
import 'package:learning_app/models/question_database.dart';
import 'package:learning_app/widgets/main_screens/home_widget/avatar_home_widget.dart';
import 'package:learning_app/widgets/main_screens/home_widget/display_name_widget.dart';
import 'package:learning_app/widgets/main_screens/question_widget/user_question_card.dart';
import 'package:learning_app/widgets/main_screens/question_widget/list_filter_card.dart';
import 'enter_question_form.dart';

class QuestionWidget extends StatefulWidget {
  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  dynamic tx = DateTime.now();
  List listQuestion = [];
  List<Widget> listQuestionWidget = [];
  List listFilter = [];
  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      getData();
    }

  void getData()async {
    List res = await QuestionDataBase().getListQuestion();
    setState(() {
          listQuestion = res;
          listQuestionWidget = res.map((question) => new QuestionCard(question)).toList();
        });
  }
  void updateFilter(String tag)async{
    if (listFilter.indexOf(tag)==-1)
      listFilter.add(tag);
    else listFilter.remove(tag);
    // print(listFilter);
    //asdfasfd
    List res = await QuestionDataBase().getListQuestion();
    List res2 = new List.from(res);
    bool ok;
     if (listFilter.length !=0)
        res2.forEach((question){
          ok = false;
          for (int j =0;j< question['tag'].length;j++){
            if (listFilter.contains(question['tag'][j]))
              ok = true;
          }
          if (!ok)
            res.remove(question);
        });
    // print(res);
    List listWidget = res.map((question) => new QuestionCard(question)).toList();
    setState(() {
          listQuestion = res2;
          listQuestionWidget = new List.from(listWidget);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(330),
            width: ScreenUtil().setWidth(375),
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/top_background.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
              color: Color(0xfffffdfa),
              boxShadow: [
                BoxShadow(
                    color: Color(0x19454545),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(106)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(24),
                        height: ScreenUtil().setHeight(40),
                      ),
                      AvatarHomeWidget(48),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(258),
                            margin: EdgeInsets.only(bottom: 4),
                            child: Container(
                                child: DisplayName(
                                  title: 'Hello ',
                                  style: TextStyle(
                                    fontFamily: 'SFProDisplay',
                                    color: Color(0xff000000),
                                    fontSize: ScreenUtil().setSp(14,
                                        allowFontScalingSelf: true),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                )),
                          ),
                          Container(
                            child: Text(
                              "Today is " +
                                  DateFormat.yMMMMEEEEd().format(tx),
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xff000000),
                                fontSize: ScreenUtil().setSp(12,
                                    allowFontScalingSelf: false),
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                AddQuestionWidget(),
              ],
            ),
          ),
          
          SizedBox(
            height: ScreenUtil().setHeight(20),
            width: ScreenUtil().setWidth(360),
          ),
          Center(
            child: Container(
                width: ScreenUtil().setWidth(312),
                child: ListFilter(updateFilter)),
          ),
          Column(
            children:listQuestionWidget
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/models/google_sign_in.dart';
import 'package:learning_app/models/users_database.dart';
import 'package:learning_app/widgets/login_screens/warning.dart';
import 'package:learning_app/widgets/main_screens/home_widget/display_name_widget.dart';
import 'package:learning_app/widgets/main_screens/user_profile_widget/background_image_profile_widget.dart';
import 'package:learning_app/widgets/main_screens/user_profile_widget/course_completed_widget.dart';
import 'package:learning_app/widgets/main_screens/user_profile_widget/journey_completed_widget.dart';
import 'package:learning_app/widgets/main_screens/user_profile_widget/user_infor.dart';
import 'package:provider/provider.dart';

import 'edit_profile_screen.dart';

String checkRanking(point) {
  if (point >= 0 && point<= 99)
    return "Newbie";
  if (point >= 100 && point<= 199)
    return "Rookie";
  if (point >= 200 && point<= 299)
    return "Fellow";
  if (point >= 300 && point<= 399)
    return "Scholar";
  if (point >= 400 && point<= 499)
    return "Conqueror";
  if (point >= 500 && point<= 599)
    return "Sage";
}
String messageRanking(point) {
  if (point >= 0 && point<= 99)
    return "Earn 100 points to become a Rookie.\nFirst, let’s get to studying. Then review the courses you learned. And finally, build our community with Workshops and Q&A.";
  if (point >= 100 && point<= 199)
    return "Earn 200 points to become a Fellow.\nKeep studying. Review your finished courses. And remember to build our community with Workshops and Q&A.";
  if (point >= 200 && point<= 299)
    return "Earn 300 points to become a Scholar.\n Keep studying. Review your finished courses. And remember to build our community with Workshops and Q&A";
  if (point >= 300 && point<= 399)
    return "Earn 400 points to become a Conqueror.\nKeep studying. Review your finished courses. And remember to build our community with Workshops and Q&A.";
  if (point >= 400 && point<= 499)
    return "Earn the highest title, the Sage, at Jobscape with 500 points.\nKeep studying. Review your finished courses. And remember to build our community with Workshops and Q&A.";
  if (point >= 500 && point<= 599)
    return "Congratulations! You are in the top 1% of Jobscape learners who have worked hard and smart as well as actively supported others as you grow.\nContinue studying and reviewing your favorite courses. You can guide and inspire other learners via Workshops and Q&A.";
}
class UserProfileWidget extends StatefulWidget {
  final Function selectPage;
  UserProfileWidget(this.selectPage);
  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  void changeScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditUserProfile()),
    );
  }

  int courseCompleted = 0;
  int journeyCompleted = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    Map userInfor = await UserDatabaseService().getUserInfor();
    setState(() {
      courseCompleted = userInfor['completed_course'];
      journeyCompleted = userInfor['journeyCompleted'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BackgroundProfileWidget(),
      Container(
        width: ScreenUtil().setWidth(360),
        height: ScreenUtil().setHeight(760),
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_user_profile.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(210)),
          // padding: EdgeInsets.only(left: ScreenUtil().setWidth(24),right: ScreenUtil().setWidth(24)),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(24)),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          right: ScreenUtil().setWidth(10),
                        ),
                        child: DisplayName(
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            color: Color(0xff000000),
                            fontSize: ScreenUtil()
                                .setSp(20, allowFontScalingSelf: false),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        changeScreen(context);
                      },
                      child: Container(
                        width: ScreenUtil().setWidth(16),
                        height: ScreenUtil().setHeight(16),
                        decoration: new BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/edit_icon.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              UserInforWidget(),
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(6),
                    bottom: ScreenUtil().setHeight(36),
                    left: ScreenUtil().setWidth(24)),
                child: Text(FirebaseAuth.instance.currentUser.email,
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xff000000),
                      fontSize:
                          ScreenUtil().setSp(15, allowFontScalingSelf: false),
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    )),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async{
                          int res = await UserDatabaseService().getUserReputation();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Membership(
                                    checkRanking(res),
                                    messageRanking(res),
                                    res);
                              });
                        },
                      child: Column(
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(40),
                            height: ScreenUtil().setHeight(40),
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/images/scholar_icon.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async{
                              int res = await UserDatabaseService().getUserReputation();
                              print(res);
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(top: ScreenUtil().setHeight(4)),
                              child: Text("Scholar\nRanking",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'SFProDisplay',
                                    color: Color(0xff000000),
                                    fontSize: ScreenUtil()
                                        .setSp(14, allowFontScalingSelf: false),
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: 0,
                        height: ScreenUtil().setHeight(68),
                        decoration: new BoxDecoration(
                          border: Border.all(color: Color(0xFFEEEEEE)),
                        )),
                    Column(
                      children: [
                        Text(courseCompleted.toString(),
                            style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              color: Color(0xffffd3a3),
                              fontSize: ScreenUtil()
                                  .setSp(35, allowFontScalingSelf: false),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(4)),
                          child: Text("Courses\nCompleted",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xff000000),
                                fontSize: ScreenUtil()
                                    .setSp(14, allowFontScalingSelf: false),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      ],
                    ),
                    Container(
                        width: 0,
                        height: ScreenUtil().setHeight(68),
                        decoration: new BoxDecoration(
                          border: Border.all(color: Color(0xFFEEEEEE)),
                        )),
                    Column(
                      children: [
                        Text(journeyCompleted.toString(),
                            style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              color: Color(0xffffd3a3),
                              fontSize: ScreenUtil()
                                  .setSp(35, allowFontScalingSelf: false),
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            )),
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(4)),
                          width: ScreenUtil().setWidth(65),
                          child: Text("Journeys Completed",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xff000000),
                                fontSize: ScreenUtil()
                                    .setSp(14, allowFontScalingSelf: false),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      ],
                    ),
                    Container(
                        width: 0,
                        height: ScreenUtil().setHeight(68),
                        decoration: new BoxDecoration(
                          border: Border.all(color: Color(0xFFEEEEEE)),
                        )),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AdvanceCustomAlert(
                                  "Sorry for this inconvenience",
                                  "We are currently working on this feature and will launch soon!");
                            });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(40),
                            height: ScreenUtil().setHeight(40),
                            decoration: new BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/cv_icon.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.only(top: ScreenUtil().setHeight(4)),
                            width: ScreenUtil().setWidth(50),
                            child: Text("View your CV",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'SFProDisplay',
                                  color: Color(0xff000000),
                                  fontSize: ScreenUtil()
                                      .setSp(14, allowFontScalingSelf: false),
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CourseCompleted(widget.selectPage),
              JourneyCompleted(widget.selectPage),
            ]),
          ),
        ),
      ),
      Positioned(
        left: ScreenUtil().setWidth(306),
        top: ScreenUtil().setHeight(46),
        child: InkWell(
          onTap: () {
            final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AdvanceCustomAlert2("Log out", "Are you sure you want to logout now?",() {provider.logout();});
                });
            //provider.logout();
          },
          child: Container(
            width: ScreenUtil().setWidth(30),
            height: ScreenUtil().setHeight(30),
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logout_icon.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

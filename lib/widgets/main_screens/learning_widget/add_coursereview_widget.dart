import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning_app/models/industry_database.dart';
import 'package:learning_app/models/google_sign_in.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning_app/models/users_database.dart';
import 'package:learning_app/widgets/main_screens/workshop_widget/list_view_reminder_widget.dart';

class AddReviewFormWidget extends StatelessWidget {
  final path;
  AddReviewFormWidget(this.path);
  int rating;
  final reviewText = TextEditingController();
  final courseReviewDataBase = DatabaseManager();
  void submitReview(BuildContext ctx) async{
    if (rating == null)
    {
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Rating must not be null!'),
          duration: Duration(milliseconds: 500),
        )
      );
      return;
    }
    if (reviewText.text == '')
    {
      print(rating.toString());
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Please enter your review !'),
          duration: Duration(milliseconds: 500),
        )
      );
      return;
    }
    // FirebaseAuth.instance.currentUser.displayName
    String displayName = await UserDatabaseService().getUserDisplayname();
    Map<String, dynamic> reviews = {
      "user": displayName,
      "reviewText": "Default",
      "upvote": 0,
      "star": 0,
      "time": DateTime.now(),
      "userId" : FirebaseAuth.instance.currentUser.uid,
    };
    reviews['star'] = rating;
    reviews['reviewText'] = reviewText.text;
        // 'This course is very wonderful for newbies like me. Very well explain, the professor are so helpful. Thank you Jobscape';
    courseReviewDataBase.addReview(reviews, path)
      .then((_) {
        reviewText.text = '';
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(24),
                  top: ScreenUtil().setHeight(25)),
              child: Text("Reviews",
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Color(0xff000000),
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  )),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(8)),
                child: RatingBar.builder(
                    itemSize: 20,
                    minRating: 1,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    direction: Axis.horizontal,
                    itemBuilder: (context, _) => Icon(
                          Icons.star_rounded,
                          color: Color(0xffffbf2f),
                        ),
                    onRatingUpdate: (rating) {
                      this.rating = rating.round();
                      // print(rating);
                    }),
              ),
            ),
            Center(
                child: Stack(
              children: [
                Container(
                  width: ScreenUtil().setWidth(312),
                  height: ScreenUtil().setHeight(71),
                  child: TextField(
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xff000000),
                      fontSize: ScreenUtil().setSp(11),
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[100],
                        ),
                      ),
                      hintText:
                          "Tell us about your own personal experience taking this course.",
                      suffixIcon: IconButton(
                        onPressed: () {submitReview(context);},
                        icon: Icon(Icons.send,color: Color(0xffffbf2f))
                      ),
                      hintStyle: TextStyle(
                        fontFamily: 'SFProDisplay',
                        color: Color(0xff888888),
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    controller: reviewText,
                  ),
                ),
              ],
            )),
          ],
        ));
  }
}

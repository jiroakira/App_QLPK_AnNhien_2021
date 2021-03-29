import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medapp/components/assignment_card/assignment_card_file_element.dart';
import 'package:medapp/components/assignment_card/file_wrapper.dart';
import 'package:medapp/components/colors/school_toolkit_colors.dart';
import 'package:medapp/components/deadline_card/deadline_card.dart';
import 'package:medapp/components/font_size/font_size.dart';
// import 'package:medapp/components/utils/screen_size.dart';

class AssignmentCard extends StatelessWidget {
  final String question;
  final String subject;
  final String teacher;
  final DateTime deadline;
  final Color deadlineBackgroundColor;
  final Color deadlineTextColor;
  final Function onUploadHandler;
  final List<FileWrapper> fileList;

  const AssignmentCard({
    Key key,
    this.question,
    this.subject,
    this.teacher,
    this.deadline,
    this.deadlineBackgroundColor,
    this.deadlineTextColor,
    this.onUploadHandler,
    this.fileList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      constraints: BoxConstraints(
        minHeight: 140,
      ),
      decoration: BoxDecoration(
        color: SchoolToolkitColors.blueGrey,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.code,
                color: SchoolToolkitColors.mediumGrey,
                size: 16,
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 320,
                child: Text(
                  '$question',
                  style: TextStyle(
                    color: SchoolToolkitColors.darkBlack,
                    fontSize: 16,
                    fontWeight: FontSize.semiBold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.fileMedical,
                color: SchoolToolkitColors.mediumGrey,
                size: 16,
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: Text(
                  '$subject',
                  style: TextStyle(
                    color: SchoolToolkitColors.mediumGrey,
                    fontSize: 14,
                    fontWeight: FontSize.medium,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.fileMedicalAlt,
                color: SchoolToolkitColors.mediumGrey,
                size: 16,
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: Text(
                  '$teacher',
                  style: TextStyle(
                    color: SchoolToolkitColors.mediumGrey,
                    fontSize: 14,
                    fontWeight: FontSize.medium,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (deadline != null)
                DeadlineCard(
                  deadline: deadline,
                  primaryColor: deadlineTextColor,
                  secondaryColor: deadlineBackgroundColor,
                ),
              Expanded(
                child: Container(),
              ),
              if (onUploadHandler != null)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 36,
                    maxWidth: 36,
                  ),
                  child: FlatButton(
                    onPressed: onUploadHandler,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      side: BorderSide(
                        color: SchoolToolkitColors.blue,
                        width: 1,
                      ),
                    ),
                    splashColor: SchoolToolkitColors.lightBlue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: Icon(
                      Icons.file_upload,
                      size: 18,
                      color: SchoolToolkitColors.blue,
                    ),
                  ),
                ),
            ],
          ),
          if (fileList != null && ((fileList?.length ?? 0) > 0)) ...[
            SizedBox(
              height: 10,
            ),
            ...fileList?.map((e) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                ),
                child: AssignmentCardFileElement(fileWrapper: e),
              );
            })?.toList(),
          ]
        ],
      ),
    );
  }
}

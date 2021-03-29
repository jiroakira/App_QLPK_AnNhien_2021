import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medapp/components/assignment_card/file_wrapper.dart';
import 'package:medapp/components/colors/school_toolkit_colors.dart';
import 'package:medapp/components/font_size/font_size.dart';

class AssignmentCardFileElement extends StatelessWidget {
  final FileWrapper fileWrapper;

  const AssignmentCardFileElement({
    Key key,
    @required this.fileWrapper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.file,
          color: SchoolToolkitColors.mediumGrey,
          size: 16,
        ),
        SizedBox(
          width: 7,
        ),
        Expanded(
          child: GestureDetector(
            onTap: fileWrapper.onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    '${fileWrapper.fileName}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: SchoolToolkitColors.blue,
                      fontSize: 14,
                      fontWeight: FontSize.medium,
                    ),
                  ),
                ),
                if (fileWrapper.fileSize != null)
                  Text(
                    '${fileWrapper.fileSize}',
                    style: TextStyle(
                      color: SchoolToolkitColors.mediumGrey,
                      fontSize: 14,
                      fontWeight: FontSize.medium,
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: fileWrapper.onTap,
          child: Container(
            width: 32,
            height: 32,
            padding: EdgeInsets.all(
              5,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              fileWrapper.icon,
              size: 14,
              color: SchoolToolkitColors.mediumGrey,
            ),
          ),
        ),
      ],
    );
  }
}

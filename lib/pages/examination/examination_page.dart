import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:medapp/components/font_size/font_size.dart';

import '../../components/custom_profile_item.dart';

class ExaminationPage extends StatefulWidget {
  @override
  _ExaminationPageState createState() => _ExaminationPageState();
}

class _ExaminationPageState extends State<ExaminationPage> with AutomaticKeepAliveClientMixin<ExaminationPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Danh Sách Các Kết Quả Khám",
          style: TextStyle(
            fontSize: FontSize.fontSize18,
            fontWeight: FontSize.semiBold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomProfileItem(
                onTap: () {},
                title: 'physical_examination'.tr(),
                subTitle: '14/02/2019',
                buttonTitle: 'see_reports'.tr(),
                imagePath: 'assets/images/icon_examination.png',
              ),
              SizedBox(
                height: 20,
              ),
              CustomProfileItem(
                onTap: () {},
                title: 'mri_examination'.tr(),
                subTitle: '12/02/2019',
                buttonTitle: 'see_reports'.tr(),
                imagePath: 'assets/images/icon_examination.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

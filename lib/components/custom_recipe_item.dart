import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomRecipeItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String days;
  final String pills;
  final String unit;

  const CustomRecipeItem({Key key, @required this.title, @required this.subTitle, @required this.days, @required this.pills, this.unit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      // padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(4),
      //   border: Border.all(width: 1, color: Colors.grey[200]),
      // ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30,
                  child: Image.asset(
                    'assets/images/icon_pill_bottle.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'NunitoSans',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Divider(
              height: 1,
              color: Colors.grey[200],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 2, right: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Cách Dùng'.tr(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            days,
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 2, right: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Số Lượng",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          pills,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 2, right: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "ĐVT",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          unit,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

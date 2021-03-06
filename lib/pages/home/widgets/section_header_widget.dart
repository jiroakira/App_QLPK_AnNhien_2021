import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final Function onPressed;

  const SectionHeaderWidget({
    Key key,
    @required this.title,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          onPressed != null
              ? FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    'Xem Thêm'.tr(),
                    style: Theme.of(context).textTheme.button.copyWith(
                          fontSize: 12,
                        ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

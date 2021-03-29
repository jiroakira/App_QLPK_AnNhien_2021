import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../components/round_icon_button.dart';
import '../../../utils/constants.dart';

class NextAppointmentWidget extends StatelessWidget {
  final String time;
  final String patient;
  final String doctor;

  const NextAppointmentWidget({Key key, this.time, this.patient, this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: kColorBlue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      patient,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              RoundIconButton(
                onPressed: () {},
                icon: Icons.map,
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
            height: 20,
            thickness: 0.5,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/images/icon_doctor_1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Phòng Khám Medotis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    doctor,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

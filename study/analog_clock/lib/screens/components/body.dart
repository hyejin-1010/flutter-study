import 'package:analog_clock/screens/components/time_in_hour_and_minute.dart';
import 'package:flutter/material.dart';
import 'clock.dart';
import 'country_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Text(
              'Newport Beach, USA | PST',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TimeInHourAndMinute(),
            Clock(),
            Spacer(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget  >[
                  CountryCard(
                    country: 'New York, USA',
                    timeZone: '+3 HRS | EST',
                    iconSrc: 'assets/icons/Liberty.svg',
                    time: '9:20',
                    period: 'PM',
                  ),
                  CountryCard(
                    country: 'New York, USA',
                    timeZone: '+3 HRS | EST',
                    iconSrc: 'assets/icons/Liberty.svg',
                    time: '9:20',
                    period: 'PM',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


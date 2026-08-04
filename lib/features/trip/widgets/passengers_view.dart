import 'package:flutter/material.dart';
import 'package:hoooob_app/features/trip/widgets/passengers_item.dart';

class PassengersView extends StatelessWidget {
  const PassengersView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context,index){
      return PassengersItem();
    });
  }
}

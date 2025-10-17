import 'package:flutter/material.dart';
import 'package:shop_app/core/res/app_colors.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  double width;


  CustomButton({
    super.key,
    required this.text,
    this.width=183,
    required this.onPressed,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: 54,
        child: InkWell(
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: const BorderRadius.all(Radius.circular(17)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child:Text(text,style: const TextStyle(
                  fontSize: 15,color: Colors.white,
                ),),
                
                //  CustomText(
                //   text: text,
                //   fontSize: 15,
                //   alignment: Alignment.center,
                //   color: Colors.white,
                // ),
              ),
            ),
            onTap: () {
              onPressed();
            })

       
        );
  }
}

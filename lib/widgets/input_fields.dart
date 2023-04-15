import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';


class InputFields extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const InputFields({Key? key,
  required this.title,
   required this.hint,
    this.controller,
    this.widget

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
          style: titleStyle,
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border:Border.all(
                color: Colors.grey,
                width: 1.0,

              )
            ),
            child: Row(
              children: [
                Expanded(child:
                TextFormField(
                  readOnly: widget==null?false:true,
                  autofocus: false,
                  cursorColor:Get.isDarkMode?Colors.grey[100]:Colors.grey[700] ,
                  controller: controller,
                  style: subTitleStyle,
                  decoration: InputDecoration(
                  hintText: hint,
                    hintStyle: subTitleStyle,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0
                      )
                    )


                  ),


                )
                ),
                widget==null?Container():Container(child:widget)
              ],
            ),

          )

        ],
      ),
    );
  }

  TextStyle get titleStyle{
    return GoogleFonts.lato(
        textStyle:  TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Get.isDarkMode?Colors.white:Colors.black

        )

    );

  }
  TextStyle get subTitleStyle{
    return GoogleFonts.lato(
        textStyle:  TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600],
        ),


    );

  }
}

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_app/screens/add_task.dart';
import 'package:task_app/services/theme_service.dart';
import 'package:task_app/services/theme.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate  = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children:  [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()),
                        style: subHeadingStyle,

                      ),
                      Text('Today',style: headingStyle,)

                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(const AddTaskScreen());
                  },
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF4e5ae8)
                    ),
                    child:  Center(
                      child: Text(
                        '+ Add Task' ,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Colors.white
                          )
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20,left: 20),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: const Color(0xFF4e5ae8),
                selectedTextColor: Colors.white,
                dateTextStyle: GoogleFonts.lato(
                    textStyle :const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 20
                    )
                ),
                dayTextStyle: GoogleFonts.lato(
                    textStyle :const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                ),
                monthTextStyle: GoogleFonts.lato(
                    textStyle :const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 14
                    )
                ),
                onDateChange: (date){
                  _selectedDate =date;
                },
              ),
            )

          ],
        ),
      ),
    );
  }

  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: (){
          ThemeServices().switchTheme();
        },
        child:  Icon(Get.isDarkMode?Icons.nightlight_round:Icons.sunny,
        size: 20,
          color: Get.isDarkMode?Colors.white:Colors.black,
        ),
      ),
      actions:  [
        Icon(Icons.person,
        color: Get.isDarkMode?Colors.white:Colors.black,
        ),

      ],
    );
  }

  TextStyle get subHeadingStyle{
    return GoogleFonts.lato(
        textStyle:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Get.isDarkMode?Colors.grey[400]:Colors.grey
        )

    );
  }

  TextStyle get headingStyle{
    return GoogleFonts.lato(
        textStyle:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Get.isDarkMode?Colors.grey[400]:Colors.grey

        )

    );
  }
}

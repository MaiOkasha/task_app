import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_app/controllers/task_controller.dart';
import 'package:task_app/widgets/input_fields.dart';

import '../models/task.dart';


class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
   final TextEditingController _titleController = TextEditingController();
   final TextEditingController _noteController = TextEditingController();
   final TaskController _taskController = Get.put(TaskController());


  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = '9:30 PM';
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Task',
                style: headingStyle,
                ),
                 InputFields(title: 'Title',hint: 'Enter Title here',controller: _titleController,),
                 InputFields(title: 'Note',hint: 'Enter your note',controller: _noteController,),
                InputFields(title: 'Date',hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(onPressed: _getDateFromUser,
                    icon: const Icon(Icons.calendar_today_outlined,
                    color: Colors.grey,
                    )),),
                Row(
                  children: [
                    Expanded(child: InputFields(title: 'Start Date',hint:_startTime ,
                    widget: IconButton(
                      onPressed: (){},icon: const Icon(Icons.access_time_rounded,
                    color: Colors.grey,
                    ),
                    ),
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(child: InputFields(title: 'End Date',hint:_endTime ,
                      widget: IconButton(
                        onPressed:  () =>_getTimeFromUser(isStartTime: false),
                        icon: const Icon(Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 18,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Color',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Get.isDarkMode?Colors.white:Colors.black
                        ),
                        ),
                        const SizedBox(height: 10,),
                        Wrap(
                          children: List<Widget>.generate(3, (int index) {
                            return  GestureDetector(
                              onTap: (){
                                setState(() {
                                  _selectedColor = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: index==0?const Color(0xFF4e5ae8):index==1?Colors.pink:Colors.amberAccent,
                                  child:_selectedColor==index? const Icon(Icons.done,
                                  color: Colors.white,
                                    size: 16,
                                  ):Container(),
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: ()=> _validateData(),
                      child: Container(
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF4e5ae8)
                        ),
                        child:  Center(
                          child: Text(
                            'Create Task' ,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: ()=> Get.back()
        ,
        child:  Icon(Icons.arrow_back_ios,
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
  TextStyle get headingStyle{
    return GoogleFonts.lato(
        textStyle:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Get.isDarkMode?Colors.white:Colors.black

        )

    );
  }

  _getDateFromUser()async{
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(2024));

    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;

      });

    }else{
      print('Somthing is wrong');
    }
  }

  _getTimeFromUser({
    required bool isStartTime
})async{
   var pickedTime = await  _showTimePicker();
   String _formatedTime = pickedTime.format(context);
   if(pickedTime==null){
     print('Time Canceled');
   }else if(isStartTime==true){
     setState(() {
       _startTime = _formatedTime;

     });

   }else if(isStartTime==false){
     setState(() {
       _endTime == _formatedTime;
     });
   }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(':')[0]),
            minute: int.parse(_startTime.split(':')[1].split('')[0])
        )
    );
  }

  _validateData(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();

    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){

      Get.snackbar('Required', 'All feilds are required!',
      snackPosition:SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: const Icon(Icons.warning_amber_rounded),
        colorText: Colors.pink
      );
    }

  }

  _addTaskToDb()async{
    /*Task(
      note : _noteController.text,
      title : _titleController.text,
      date : DateFormat.yMd().format(_selectedDate),
      startTime : _startTime,
      endTime : _endTime,
      color : _selectedColor,
      isCompleted : 0


    );*/

    await _taskController.addTask(
        task : Task(
            note : _noteController.text,
            title : _titleController.text,
            date : DateFormat.yMd().format(_selectedDate),
            startTime : _startTime,
            endTime : _endTime,
            color : _selectedColor,
            isCompleted : 0


        )
    );


  }




}

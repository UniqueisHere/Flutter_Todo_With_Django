import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend/services/listing_todo.dart';
import 'package:get/get.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool? isCompleted = false;

  final listingtodo = Get.put(ListingTodo());

  final formKey = GlobalKey<FormState>();

  final TextEditingController title = TextEditingController();

  final TextEditingController description = TextEditingController();

  final TextEditingController date = TextEditingController();

  String datePicked = '';

  String timePicked = '';

  @override
  void initState() {
    super.initState();
    isRunning();
  }

  void isRunning() async {
    await listingtodo.getDataFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('Todo With Django Backend'),
          backgroundColor: Color(0xFF001133),
          elevation: 0,
        ),
        body: !listingtodo.isLoading.value
            ? SafeArea(
                child: Container(
                  color: Color(0xFF001133),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: listingtodo.todoModel.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Container(
                                  // height: 162,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(1, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      right: 10,
                                      left: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                listingtodo
                                                    .todoModel[index].todoTitle
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 30,
                                          ),
                                          child: Text(
                                            listingtodo.todoModel[index]
                                                .todoDescription
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 4,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(listingtodo
                                                .todoModel[index].todoDate
                                                .toString()),
                                            Checkbox(
                                                value: isCompleted,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    isCompleted = newValue;
                                                  });
                                                })
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Loading'),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            dialogBox(context);
            setState(() {
              datePicked = '';
              timePicked = '';
              title.text = '';
              description.text = '';
            });
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }

  Future<dynamic> dialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            child: Form(
              child: Container(
                height: 340,
                width: 400,
                color: Color(0xFF001133),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    right: 5,
                    bottom: 10,
                    left: 10,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add Your Todo's",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: title,
                          validator: (String? value) {
                            String val = value ?? '';
                            if (val.isEmpty) {
                              return 'Please Enter The Title Of Your Task';
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: Color.fromARGB(255, 251, 182, 165),
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            labelText: "Enter Your Title for Your Task",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 30,
                            ),
                            hintText: "Example: Cleaning House",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: description,
                          validator: (String? value) {
                            String val = value ?? '';
                            if (val.isEmpty) {
                              return 'Please Enter The Description Of Your Task';
                            }
                            return null;
                          },
                          style: TextStyle(
                            color: Color.fromARGB(255, 251, 182, 165),
                            fontSize: 13,
                          ),
                          decoration: InputDecoration(
                            labelText: "Fully Describe Your Task",
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 30,
                            ),
                            hintText:
                                "Example: I need to clean my house by 4:30PM.",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // TextFormField(
                        //   controller: date,
                        //   validator: (String? value) {
                        //     String val = value ?? '';
                        //     if (val.isEmpty) {
                        //       return 'Please Enter The Description Of Your Task';
                        //     }
                        //     return null;
                        //   },
                        //   onTap: () async {
                        //     DateTime? pickedDate = await showDatePicker(
                        //       context: context,
                        //       initialDate: DateTime(2023),
                        //       firstDate: DateTime(2022),
                        //       lastDate: DateTime(2050),
                        //     );
                        //     if (pickedDate != null) {
                        //       setState(() {
                        //         datePicked = pickedDate.toString();
                        //       });
                        //     }
                        //   },
                        //   decoration: InputDecoration(
                        //     labelText: "Enter Your Title of Your Task",
                        //     labelStyle: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //     ),
                        //     suffixIcon: Icon(Icons.calendar_month),
                        //     contentPadding: const EdgeInsets.only(
                        //       left: 30,
                        //     ),
                        //     hintText:
                        //         "Example: I need to clean my house by 4:30PM.",
                        //     hintStyle: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //     ),
                        //     enabledBorder: UnderlineInputBorder(
                        //       borderSide: BorderSide(
                        //         width: 3,
                        //         color: Colors.white,
                        //       ),
                        //       borderRadius: BorderRadius.circular(50.0),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2023),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2050),
                                  );
                                  if (pickedDate != null) {
                                    setState(() {
                                      datePicked =
                                          '${pickedDate.year.toString()}-${pickedDate.month.toString()}-${pickedDate.day.toString()}';
                                    });
                                  }
                                },
                                child: datePicked == ''
                                    ? Text(
                                        'Add Date for the Task',
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 12,
                                        ),
                                      )
                                    : Text(
                                        datePicked,
                                        style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 14,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  var pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay(
                                      hour: 12,
                                      minute: 60,
                                    ),
                                  );
                                  if (pickedTime != null) {
                                    setState(() {
                                      timePicked =
                                          '${pickedTime.hour}:${pickedTime.minute}';
                                    });
                                  }
                                },
                                child: timePicked == ''
                                    ? Text(
                                        'Add Time for the Task',
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 12,
                                        ),
                                      )
                                    : Text(
                                        timePicked,
                                        style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 14,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 25,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print(datePicked);
                                },
                                child: Text(
                                  'ADD',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

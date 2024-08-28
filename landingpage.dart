// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';
import 'package:app/todo.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  DateTime today = DateTime.now();
  final ContentController _contentController = Get.put(ContentController());
  // final LabelController _labelController = Get.put(LabelController());
  TextEditingController product = TextEditingController();
  // TextEditingController Label = TextEditingController();
  final ToDoController todoController = Get.put(todoController);
  void initState() {
    todoController.fetchAllLabels();
    todoController.fetchAllTodo().then((value) {
      setState(() {
        pageLoaded = true;
      });
    });
    super.initState();
  }

  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      print(day);
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 10),
                      child: TextFormField(
                        controller: product,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                    Positioned(
                        right: 1,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 10,
                              top: 15,
                            ),
                            child: FloatingActionButton.small(
                              elevation: 0.0,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.add),
                              onPressed: () {
                                _contentController.addContent(product.text);
                              },
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 5,
                      child: Obx(() {
                        return _contentController.contents.isEmpty
                            ? Container(
                                height: 20,
                              )
                            : ListView.builder(
                                itemCount: _contentController.contents.length,
                                itemBuilder: (Context, index) {
                                  var e = _contentController.contents[index];
                                  return ListTile(
                                    title: Text(e),
                                    // title: TextFormField(
                                    //   decoration: InputDecoration(
                                    //     labelText:
                                    //         (_contentController.contents[index]),
                                    //   ),
                                    // ),
                                  );
                                });
                      }),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 900,
            width: 1,
            color: Colors.white,
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Container(
                  child: TableCalendar(
                    focusedDay: today,
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    firstDay: DateTime.utc(1990, 01, 01),
                    lastDay: DateTime.utc(2100, 12, 31),
                    onDaySelected: onDaySelected,
                    selectedDayPredicate: (day) => isSameDay(day, today),
                  ),
                ),
                SizedBox(
                  height: 400,
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    // _labelController.obs();
                  },
                  icon: Icon(Icons.add),
                  label: Text('Add Label'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ContentController extends GetxController {
  final RxList contents = [].obs;

  void addContent(dynamiccontents) {
    contents.add(dynamiccontents);
    print(contents);
  }
}

// class LabelController extends GetxController {
//   var isChecked = false.obs;

//   void toggleCheckbox() {
//     isChecked.value = !isChecked.value;
//   }
// }

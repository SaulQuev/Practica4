import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/task_model.dart';
import 'package:pmsn2023/models/teacher_model.dart';
import 'package:pmsn2023/screens/add_task_screen.dart';
import 'package:pmsn2023/styles/global_values.dart';

Widget taskWidget(TaskModel task, BuildContext context) {
  Agenda? agendadb = Agenda();
  return FutureBuilder(
      future: agendadb.GETTEACHER(task.teacher_id!),
      builder: (BuildContext context, AsyncSnapshot<TeacherModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.task_name!,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(snapshot.data!.teacher_name!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 12))
                  ],
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTaskScreen(
                                        taskModel: task,
                                      )));
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green)),
                        child: const Icon(
                          Icons.edit_document,
                          size: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 40,
                      child: ElevatedButton(
                          onPressed: () async {
                            ArtDialogResponse response =
                                await ArtSweetAlert.show(
                                    barrierDismissible: false,
                                    context: context,
                                    artDialogArgs: ArtDialogArgs(
                                        denyButtonText: "Cancel",
                                        title: "Are you sure?",
                                        confirmButtonText: "Yes",
                                        type: ArtSweetAlertType.warning));

                            if (response.isTapConfirmButton) {
                              agendadb.DELETE(
                                  'tasks', 'task_id', task.task_id!, null);
                              GlobalValues.flag_database.value =
                                  !GlobalValues.flag_database.value;
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero)),
                          child: const Icon(
                            Icons.delete_forever_rounded,
                            size: 14,
                          )),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something Was Wrong"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      });
}

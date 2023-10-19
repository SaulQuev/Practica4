import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2023/database/agendadb.dart';
import 'package:pmsn2023/models/career_model.dart';
import 'package:pmsn2023/models/teacher_model.dart';
import 'package:pmsn2023/styles/global_values.dart';

class AddTeacherScreen extends StatefulWidget {
  AddTeacherScreen({super.key, this.teacherModel});

  TeacherModel? teacherModel;

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  TextEditingController txtContTeacherName = TextEditingController();
  TextEditingController txtContTeacherEmail = TextEditingController();
  CareerModel? dropDownValue;
  List<CareerModel>? dropDownValues;
  Agenda? agendadb;

  @override
  void initState() {
    super.initState();
    agendadb = Agenda();
    if (widget.teacherModel != null) {
      txtContTeacherName.text = widget.teacherModel!.teacher_name!;
      txtContTeacherEmail.text = widget.teacherModel!.teacher_email!;
      getCareer();
    } else {
      getCareers();
    }
  }

  Future getCareer() async {
    final career = await agendadb!.GETCAREER(widget.teacherModel!.career_id!);
    final careers = await agendadb!.GETALLCAREERS();
    setState(() {
      dropDownValues = careers;
      for (int i = 0; i < careers.length; i++) {
        if (careers[i].career_id == career.career_id) {
          dropDownValue = careers[i];
          break;
        }
      }
    });
  }

  Future getCareers() async {
    final careers = await agendadb!.GETALLCAREERS();
    setState(() {
      dropDownValues = careers;
      dropDownValue = careers[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtTeacherName = TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Nombre de Profesor")),
      controller: txtContTeacherName,
    );

    final txtTeacherEmail = TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Correo Electronico")),
      controller: txtContTeacherEmail,
    );

    const space = SizedBox(
      height: 10,
    );

    final btnSave = ElevatedButton(
        onPressed: () {
          if (widget.teacherModel == null) {
            if (txtContTeacherName.text == "" ||
                txtContTeacherEmail.text == "") {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: "¡Advertencia!",
                      text: "Porfavor, llenar todos lo espacios"));
            } else {
              agendadb!.INSERT('teachers', {
                "teacher_name": txtContTeacherName.text,
                "teacher_email": txtContTeacherEmail.text,
                "career_id": dropDownValue!.career_id
              }).then((value) {
                var msj = (value > 0)
                    ? 'Profesor Agregado Correctamente'
                    : 'Algo Fallo';
                var snackBar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              });
            }
          } else {
            agendadb!.UPDATE('teachers', 'teacher_id', {
              "teacher_id": widget.teacherModel!.teacher_id,
              "teacher_name": txtContTeacherName.text,
              "teacher_email": txtContTeacherEmail.text,
              "career_id": dropDownValue!.career_id
            }).then((value) {
              var msj = (value > 0)
                  ? 'Profesor Actualizado Correctamente'
                  : 'Algo Fallo';
              var snackBar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Navigator.pop(context);
            });
          }
          GlobalValues.flag_database.value = !GlobalValues.flag_database.value;
        },
        child: const Text("Guardar"));

    final DropdownButton dropDownButtonCareer = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            ?.map((career) => DropdownMenuItem(
                value: career, child: Text(career.career_name!)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    return Scaffold(
      appBar: AppBar(
        title: widget.teacherModel == null
            ? const Text('Agregar Profesor')
            : const Text('Actualizar Profesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            txtTeacherName,
            space,
            txtTeacherEmail,
            space,
            dropDownButtonCareer,
            space,
            btnSave
          ],
        ),
      ),
    );
  }
}

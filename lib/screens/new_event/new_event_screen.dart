import 'package:eventcountdown/screens/home/home_screen.dart';
import 'package:eventcountdown/screens/new_event/widgets/date_picker_text_field.dart';
import 'package:eventcountdown/screens/new_event/widgets/description_textfield.dart';
import 'package:eventcountdown/screens/new_event/widgets/rounded_text_fields.dart';
import 'package:eventcountdown/screens/new_event/widgets/save_button.dart';
import 'package:eventcountdown/utils/textfields_validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/event.dart';
import '../../services/sql_helper.dart';
import '../../utils/app_colors.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final locationController = TextEditingController();
  final SqlHelper sqlHelper = SqlHelper();

  // ignore: unused_field, prefer_final_fields
  bool _initialized = false;

  // ignore: prefer_final_fields
  bool _editMode = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "New Event",
          style: TextStyle(
              color: AppColors.whiteColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 95), //navbar height

                children: [
                  // Personal Informations

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    "Tell us about your event — add title, date, and where it's happening!",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //tittle textfield
                  RoundedTextField(
                    validator: Validators().requiredFieldValidator,
                    controller: titleController,
                    keyboardType: TextInputType.name,
                    labelText: "Title*",
                  ),

                  const SizedBox(height: 15),

                  const SizedBox(height: 15),
                  DescriptionTextField(
                    validator: Validators().requiredFieldValidator,
                    controller: descriptionController,
                    labelText: "Description*",
                  ),
                  //Year start date textfield

                  const SizedBox(height: 15),

                  //Month start date textfield
                  DatePickerField(
                    validator: Validators().requiredFieldValidator,
                    controller: dateController,
                    labelText: "Date*",
                    pickerType: "date",
                  ),

                  const SizedBox(height: 15),

                  // TimePickerField(
                  //     controller: timeController, labelText: "Time*"),

                  DatePickerField(
                    validator: Validators().requiredFieldValidator,
                    controller: timeController,
                    labelText: "Time*",
                    pickerType: "time",
                  ),

                  //Year end date textfield

                  const SizedBox(height: 15),
                  RoundedTextField(
                    validator: Validators().requiredFieldValidator,
                    controller: locationController,
                    keyboardType: TextInputType.name,
                    labelText: "Location*",
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  _editMode
                      ? Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.lightColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                              padding: EdgeInsets.all(13),
                              child: InkWell(
                                // onTap: () => _deleteEdution(),
                                child: Text(
                                  "Delete Event",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          // Save Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SaveButton(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  sqlHelper.addEvent(
                    Event(
                      titleController.text,
                      descriptionController.text,
                      dateController.text,
                      timeController.text,
                      locationController.text,
                    ),
                  );
                  Get.to(
                    const HomeScreen(),
                    transition: Transition.fadeIn,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// String timeString = "14:30"; // or "14:30:00"
// DateFormat inputFormat = DateFormat("HH:mm"); // use "HH:mm:ss" if seconds are included
// DateTime time = inputFormat.parse(timeString);
//
// // Convert to SQL TIME format
// String sqlTime = DateFormat("HH:mm:ss").format(time);

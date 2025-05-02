import 'package:eventcountdown/constants/app_colors.dart';
import 'package:eventcountdown/services/textfields_validators.dart';
import 'package:eventcountdown/widgets/description_textfield.dart';
import 'package:eventcountdown/widgets/date_picker_text_field.dart';
import 'package:eventcountdown/widgets/rounded_text_fields.dart';
import 'package:eventcountdown/widgets/save_button.dart';
import 'package:flutter/material.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationeController = TextEditingController();

  // ignore: unused_field, prefer_final_fields
  bool _initialized = false;
  // ignore: prefer_final_fields
  bool _editMode = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationeController.dispose();

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
                    "Tell us about your event — add the name, date, and where it's happening!",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //tittle textfield
                  RoundedTextField(
                    validator: Validators().requiredFieldValidator,
                    controller: _titleController,
                    keyboardType: TextInputType.name,
                    labelText: "Title*",
                  ),

                  const SizedBox(height: 15),

                  const SizedBox(height: 15),
                  DescriptionTextField(
                    validator: Validators().requiredFieldValidator,
                    controller: _descriptionController,
                    labelText: "Description*",
                  ),
                  //Year start date textfield

                  const SizedBox(height: 15),

                  //Month start date textfield
                  DatePickerField(
                    validator: Validators().requiredFieldValidator,
                    controller: _dateController,
                    labelText: "Date*",
                    pickerType: "date",
                  ),

                  const SizedBox(height: 15),

                  DatePickerField(
                    validator: Validators().requiredFieldValidator,
                    controller: _timeController,
                    labelText: "Time*",
                    pickerType: "time",
                  ),

                  //Year end date textfield

                  const SizedBox(height: 15),
                  RoundedTextField(
                    validator: Validators().requiredFieldValidator,
                    controller: _locationeController,
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
                            child: Padding(
                              padding: const EdgeInsets.all(13),
                              child: InkWell(
                                // onTap: () => _deleteEdution(),
                                child: const Text(
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
            // child: SaveButton(
            //   onTap: () {},
            // )

            child: SaveButton(onTap: () {}),
          ),
        ],
      ),
    );
  }
}

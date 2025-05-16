import 'package:eventcountdown/screens/nav_bar_screen/nav_bar_screen.dart';
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
  const NewEventScreen({super.key, this.editMode = false, this.event});

  final editMode;
  final Event? event;

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
    if (!_initialized) {
      if (widget.editMode) {
        titleController.text = widget.event!.title;
        descriptionController.text = widget.event!.description;
        dateController.text = widget.event!.date;
        timeController.text = widget.event!.time;
        locationController.text = widget.event!.location;
      }
      _initialized = true;
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          widget.editMode ? "Edit Event" : "New Event",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightColor,
        foregroundColor: AppColors.darkColor,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView(
                padding: const EdgeInsets.only(bottom: 95),
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Tell us about your event — add title, date, and where it's happening!",
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 30),
                  RoundedTextField(
                    validator: Validators().requiredFieldValidator,
                    controller: titleController,
                    keyboardType: TextInputType.name,
                    labelText: "Title",
                  ),
                  const SizedBox(height: 30),
                  DescriptionTextField(
                    controller: descriptionController,
                    labelText: "Description",
                  ),
                  const SizedBox(height: 30),
                  DateAndTimePickerField(
                    validator: Validators().requiredFieldValidator,
                    controller: dateController,
                    labelText: "Date",
                    pickerType: "date",
                  ),
                  const SizedBox(height: 15),
                  DateAndTimePickerField(
                    validator: Validators().requiredFieldValidator,
                    controller: timeController,
                    labelText: "Time",
                    pickerType: "time",
                  ),
                  const SizedBox(height: 15),
                  RoundedTextField(
                    validator: Validators().requiredFieldValidator,
                    controller: locationController,
                    keyboardType: TextInputType.name,
                    labelText: "Location",
                  ),
                  const SizedBox(height: 30),
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
                  widget.editMode
                      ? sqlHelper.updateEvent(
                          Event(
                            titleController.text,
                            descriptionController.text,
                            dateController.text,
                            timeController.text,
                            locationController.text,
                            widget.event!.id,
                          ),
                        )
                      : sqlHelper.addEvent(
                          Event(
                            titleController.text,
                            descriptionController.text,
                            dateController.text,
                            timeController.text,
                            locationController.text,
                          ),
                        );
                  Get.to(
                    const NavBarScreen(),
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

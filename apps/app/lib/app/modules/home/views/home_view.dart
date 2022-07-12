import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({Key? key}) : super(key: key, alwaysUseBuilder: false);

  @override
  Widget? phone() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dominican Republic ID Validation'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.validate,
        tooltip: 'Validate',
        child: Icon(
          Icons.check,
          size: 40,
          color: Get.theme.colorScheme.surface,
        ),
      ),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: Get.theme.colorScheme.background,
            child: Icon(
              Icons.person,
              size: 100,
              color: Get.theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 30),
          _formBuilder(),
        ],
      ),
    );
  }

  Widget _formBuilder() {
    return FormBuilder(
      key: controller.formKey.value,
      initialValue: const {
        'id': '',
      },
      autovalidateMode: AutovalidateMode.always,
      child: _textField(),
    );
  }

  Widget _textField() {
    return FormBuilderTextField(
      name: 'id',
      keyboardType: TextInputType.number,
      style: Get.textTheme.headline4,
      maxLines: 1,
      maxLength: 11,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.numeric(errorText: "Invalid ID"),
        FormBuilderValidators.required(errorText: "ID is required"),
        FormBuilderValidators.minLength(11, errorText: "ID must be 11 digits"),
      ]),
      decoration: InputDecoration(
        hintText: 'Enter your ID',
        suffixIcon: const Icon(Icons.card_membership, size: 60),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

import 'package:app/app/data/validation.model.dart';
import 'package:app/app/modules/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<Validation> {
  final _homeProvider = Get.find<HomeProvider>();
  final isLoading = false.obs;
  final formKey = GlobalKey<FormBuilderState>().obs;

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  void validate() async {
    if (_validateForm()) {
      change(null, status: RxStatus.loading());
      isLoading.value = true;

      final id = formKey.value.currentState!.value['id'];
      final response = await _homeProvider.validate(id);

      if (response.isOk) {
        change(response.body, status: RxStatus.success());

        Get.showSnackbar(GetSnackBar(
          title: 'Success',
          messageText: Text("The ID is ${state!.valid ? 'valid' : 'invalid'}"),
          backgroundColor: state!.valid ? Colors.green : Colors.orange,
          duration: const Duration(seconds: 3),
        ));
      }

      if (!response.isOk) {
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          messageText: Text(response.body!.message!),
          backgroundColor: Get.theme.errorColor,
          duration: const Duration(seconds: 3),
        ));

        change(null, status: RxStatus.error());
      }

      isLoading.value = false;
    }
  }

  bool _validateForm() {
    return formKey.value.currentState!.saveAndValidate();
  }
}

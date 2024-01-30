// import 'dart:developer';
// import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
// import '../../../data/provider/storage_provider.dart';
// import '../../../routes/app_pages.dart';
import 'package:dio/dio.dart' as dio;

import '../../../routes/app_pages.dart';

class AddBookController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahunTerbitController = TextEditingController();
  final loading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // You can add any initialization logic if needed
  }

  @override
  void onClose() {
    super.onClose();
  }

  add() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate());
      {
        final response = await ApiProvider.instance().post(Endpoint.book,
            data: {
              "judul": judulController.text.toString(),
              "penulis": penulisController.text.toString(),
              "penerbit": penerbitController.text.toString(),
              "tahun_terbit": int.parse(tahunTerbitController.text.toString()),
        });
        if (response.statusCode == 201) {
          Get.snackbar("Selamat", "Login Berhasil", backgroundColor: Colors.greenAccent);
          Get.offAllNamed(Routes.BOOK);
          // Get.back();
        } else {
          Get.snackbar("Sorry", "Login Gagal", backgroundColor: Colors.orange);
        }
      }loading(false);
    } on dio.DioException catch (e) {loading(false);
    if (e.response != null) {
      if (e.response?.data != null) {
        Get.snackbar("Sorry", "${e.response?.data['message']}", backgroundColor: Colors.orange);
      }
    } else {
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    }
    } catch (e) {loading(false);
    Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
    }
  }
}

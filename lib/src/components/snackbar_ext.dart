import 'package:flutter/material.dart';
import 'package:get/get.dart';

setErrorSnackbar(String errorTitle, String errorMessage,
    {double overlayBluerTime = 2.0}) {
  Get.snackbar(
    errorTitle,
    errorMessage,
    backgroundColor: Colors.white,
    colorText: Colors.red,
    overlayBlur: overlayBluerTime,
    shouldIconPulse: true,
    icon: const Icon(Icons.error, color: Colors.red),
    dismissDirection: DismissDirection.horizontal,
  );
}

setSuccessSnackbar(String successMessage,
    {String successMessageSentence = "", double overlayBluerTime = 2.0}) {
  Get.snackbar(
    successMessage,
    successMessageSentence,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.white,
    colorText: Colors.teal,
    overlayBlur: overlayBluerTime,
    shouldIconPulse: true,
    icon: const Icon(Icons.verified, color: Colors.teal),
    dismissDirection: DismissDirection.endToStart,
  );
}

setGeneralMessage(String messageTitle,
    {String messageSentence = "", double overlayBluerTime = 2.0}) {
  Get.snackbar(
    messageTitle,
    messageSentence,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.white,
    colorText: Colors.teal,
    overlayBlur: overlayBluerTime,
    shouldIconPulse: true,
    icon: const Icon(Icons.verified, color: Colors.teal),
    dismissDirection: DismissDirection.endToStart,
  );
}

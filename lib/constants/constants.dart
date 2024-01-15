import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color(0xFF01C15C),
            ),
            SizedBox(
              height: 18.0,
            ),
            Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Loading..."),
            ),
          ],
        ),
      );
    }),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email sudah digunakan. Masuk ke halaman login.";
    case "account-exist-with-different-credential":
      return "Email sudah digunakan. Masuk ke halaman login.";
    case "email-already-in-use":
      return "Email sudah digunakan. Masuk ke halaman login.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Password Salah";
    case "ERROR_USER_NOT_FOUND":
      return "Pengguna tidak ditemukan dengan email ini.";
    case "user-not-found":
      return "Pengguna tidak ditemukan dengan email ini.";
    case "ERROR_USER_DISABLED":
      return "Pengguna dinonaktifkan.";
    case "user-disabled":
      return "Pengguna dinonaktifkan.";
    case "ERROR_TO_MANY_REQUESTS":
      return "Terlalu banyak permintaan untuk masuk ke akun ini.";
    case "operation-not-allowed":
      return "Terlalu banyak permintaan untuk masuk ke akun ini.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Terlalu banyak permintaan untuk masuk ke akun ini.";
    case "ERROR_INVALID_EMAIL":
      return "Alamat email salah.";
    case "invalid-email":
      return "Alamat email salah.";
    default:
      return "Proses login gagal. Silahkan coba lagi.";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Kedua kolom kosong");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email kosong");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password kosong");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(String email, String password, String username, String phone) {
  if (email.isEmpty && password.isEmpty && username.isEmpty && phone.isEmpty) {
    showMessage("Semua kolom kosong");
    return false;
  } else if (username.isEmpty) {
    showMessage("Password kosong");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email kosong");
    return false;
  } else if (phone.isEmpty) {
    showMessage("No.telp kosong");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password kosong");
    return false;
  } else {
    return true;
  }
}
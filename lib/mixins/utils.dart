// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, missing_return, avoid_unnecessary_containers

import 'package:finance_riza/style/styles.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Utils {
  static var format = new NumberFormat.currency(decimalDigits: 0, symbol: "");

  static var format2 =
      new NumberFormat.currency(decimalDigits: 0, symbol: "Rp.");

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.blue[900],
      ),
    );
  }

  Widget buildLoadingWait() {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
      ),
    );
  }

  Widget buildLoadingFalse() {
    return Center();
  }

  Widget Succes() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            child: FlareActor(
              "assets/flare/checkmark by someone.flr",
              animation: "Untitled",
            ),
          )
        ],
      ),
    );
  }

  Widget failed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            child: FlareActor(
              "assets/flare/failed_animation.flr",
              animation: "gagal",
            ),
          )
        ],
      ),
    );
  }

  Widget tidakadaOrder() {
    Center(
      child: Container(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.shopping_bag,
              color: Colors.black,
              size: 70,
            ),
            Text(
              "Tidak Ada Order",
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: AppStyles.colorDasar,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget noData() {
    return Center(
        child: Container(
            height: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: AppStyles.colorDasar,
                  size: 30,
                ),
                Container(
                  child: Text(
                    "No Data",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            )));
  }

  Widget buildMessage(IconData iconData, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.black,
              size: 70,
            ),
            Text(
              message,
              // ignore: prefer_const_constructors
              style: TextStyle(
                  color: AppStyles.colorDasar,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget ErrorKoneksiTidakStabil() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Icon(
                Icons.signal_wifi_bad_outlined,
                size: 100,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Unstable Connection",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              "Cek Koneksi Samrtphone Anda ",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              "closed aplikasi BEM & open aplikasi",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

void tunggu(context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(color: AppStyles.colorDasar),
            SizedBox(width: 20),
            Text("Loading..."),
          ],
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Test_2.dart';

class Test_1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text("仮テスト(1)")),
      body : Center(
        child: TextButton(
          child: Text("2ページ目に遷移する"),
          // （1） 前の画面に戻る
          onPressed: (){

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(

                builder: (context) => Test_2(),));
          },
        ),
      ));
  }
}
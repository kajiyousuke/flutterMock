import 'package:flutter/material.dart';

class FourthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title : Text("ページ(4)")),
      body : Center(
        child: TextButton(
          child: Text("最初のページに戻る"),
          // （1） 前の画面に戻る
          onPressed: (){
            Navigator.popUntil(context, (route) => route.isFirst);
            // （1） 指定した画面に遷移する
              // （2） 実際に表示するページ(ウィジェット)を指定する
              //Navigator.pop(context);
          },
        ),
      ));
  }
}
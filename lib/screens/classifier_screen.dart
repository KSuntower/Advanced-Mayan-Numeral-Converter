import 'package:flutter/material.dart';
import 'package:advanced_mayan_numeral_converter/helpers/classifier_list.dart';
import 'package:advanced_mayan_numeral_converter/generated/l10n.dart';

class ClassifierScreen extends StatelessWidget {
  const ClassifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          IconButton(onPressed: null,
              icon: Icon(Icons.info_outline))],
        centerTitle: true,
        title: Text(S.of(context).classifierTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          children: [
            // GestureDetector(
            //   onTap: null,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(S.of(context).classifierInfoButton),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(itemCount: classifierList.length,
                  itemBuilder: (context, index) => classifierCard(context, index)),
            ),
          ],
        ),
      ),
    );
  }
  Widget classifierCard(BuildContext context, int index) {
    double fontSize = 20.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        child: Container(
          height: fontSize + 15,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              classifierList[index][0],
              style: TextStyle(fontSize: fontSize,
                  overflow: TextOverflow.fade),
            ),
          ),
        ),
      ),
    );
  }
}

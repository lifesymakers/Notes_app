import 'package:flutter/material.dart';

class CardAdd extends StatelessWidget {
  TextEditingController textFieldController1 = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white,
          width: 5.0,
          style: BorderStyle.solid,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: textFieldController1,
                decoration: InputDecoration(
                  hintText: 'Write title of note',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: textFieldController2,
                decoration: InputDecoration(
                  hintText: 'Write description',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Save'),
                  onPressed: () async {
                    Navigator.pop(context, {
                      'title': textFieldController1.text,
                      'note': textFieldController2.text,
                      'date': DateTime.now().toString()
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

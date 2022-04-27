import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  static const String id = 'error_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Error'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          //color: Colors.lightBlue[50],
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: Text(
                'Looks like a problem occurred. Please check your network '
                    'and try again later. If issue persists, please contact'
                    ' us. ',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

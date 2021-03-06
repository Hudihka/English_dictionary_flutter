

import 'package:flutter/material.dart';
import 'package:english_dictionary_flutter/export.dart';

class ScafoldLoad extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
        ),
      );
  }

}


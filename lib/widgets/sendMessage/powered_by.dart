// Imports
import 'dart:convert';

import 'package:flutter/material.dart';

/// Powered By, multiple optins to show this.
/// The options are blue logo, gray logo and plain text.
class PoweredBy extends StatelessWidget {
  const PoweredBy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          child: const Text(
            "Powered by",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Image.memory(
          base64Decode(
              "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"),
          height: 15,
          gaplessPlayback: true,
        ),
      ],
    );
  }
}

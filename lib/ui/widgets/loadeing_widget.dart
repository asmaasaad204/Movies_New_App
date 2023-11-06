import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:
          CircularProgressIndicator(color: Color.fromRGBO(253, 174, 26, 1.0)),
    );
  }
}

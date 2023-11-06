import 'package:flutter/material.dart';

class ErrorView extends StatefulWidget {
  final String message;

  const ErrorView({super.key, required this.message});

  @override
  State<ErrorView> createState() => _ErrorViewState();
}

class _ErrorViewState extends State<ErrorView> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: isVisible,
        child: AlertDialog(
          backgroundColor: Colors.black87,
          title: const Text("Error"),
          content: Text(
            widget.message,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    isVisible = false;
                  });
                },
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
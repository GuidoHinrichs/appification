import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class InfoScreenMile extends StatelessWidget {
  const InfoScreenMile({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Screenshots:'),
      ),
      body: const SingleChildScrollView(

      ),
    );
  }
}

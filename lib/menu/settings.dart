import 'package:flutter/material.dart';
import 'package:qrcodescanner/components/dropdown_button.dart';
import 'package:qrcodescanner/components/theme_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontFamily: 'Inter')),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Theme'),
              CustomDropdown<AppThemeMode>(
                items: AppThemeMode.values,
                value: Provider.of<ThemeProvider>(context).mode,
                onChanged: (mode) => Provider.of<ThemeProvider>(context, listen: false).setMode(mode),
                itemBuilder: (mode) {
                  switch (mode) {
                    case AppThemeMode.system:
                      return Row(children: [Icon(Icons.computer), SizedBox(width: 8), Text('System')]);
                    case AppThemeMode.light:
                      return Row(children: [Icon(Icons.wb_sunny), SizedBox(width: 8), Text('Light')]);
                    case AppThemeMode.dark:
                      return Row(children: [Icon(Icons.nightlight_round), SizedBox(width: 8), Text('Dark')]);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
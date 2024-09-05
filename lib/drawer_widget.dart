import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

const myIcon = Icon(Symbols.add_task);
const myRoundedIcon = Icon(Symbols.add_task_rounded);
const mySharpIcon = Icon(Symbols.add_task_sharp);

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // Zugriff auf das aktuelle Thema im ThemeProvider
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 140.0,
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              color: Colors.black26,
              child: const Text(
                'Deine App nach Deinem Geschmack:',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // Abschnitt für die Themenauswahl
            _buildDrawerSection(context, 'Suche Dir ein Thema aus:',
                themeProvider, Icons.palette),
            _buildThemeOption(context, 'Light', AppTheme.light, themeProvider,
                Icons.wb_sunny),
            _buildThemeOption(context, 'Dark', AppTheme.dark, themeProvider,
                Icons.nights_stay),
            _buildThemeOption(context, 'Colorful', AppTheme.colorful,
                themeProvider, Icons.color_lens),
            // Abschnitt für die Schriftenauswahl
            _buildDrawerSection(context, 'Entscheide Dich für eine Schriftart:',
                themeProvider, Icons.text_fields),
            _buildFontOption(context, 'Open Sans', AppTextTheme.openSans,
                themeProvider, Icons.font_download),
            _buildFontOption(context, 'Margarine', AppTextTheme.margarine,
                themeProvider, Icons.font_download),
            _buildFontOption(
                context,
                'Permanent Marker',
                AppTextTheme.permanentMarker,
                themeProvider,
                Icons.font_download),
          ],
        ),
      ),
    );
  }

  //Erstellen eines Abschnitts
  Widget _buildDrawerSection(BuildContext context, String title,
      ThemeProvider themeProvider, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: themeProvider.currentTheme.primaryColor.withOpacity(0.1),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Erstellen der Themen-Auswahloption
  Widget _buildThemeOption(BuildContext context, String title, AppTheme theme,
      ThemeProvider themeProvider, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title),
      onTap: () {
        themeProvider.setTheme(theme);
        Navigator.pop(context);
      },
    );
  }

  // Erstellen der Fond-Auswahloption
  Widget _buildFontOption(BuildContext context, String title,
      AppTextTheme fontTheme, ThemeProvider themeProvider, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title),
      onTap: () {
        themeProvider.setFontTheme(fontTheme);
        Navigator.pop(context);
      },
    );
  }
}

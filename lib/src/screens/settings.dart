// TODO Implement this library.import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _dataUsageEnabled = true;
  int _selectedAccessibilityOption = 0;
  List<String> _accessibilityOptions = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildNotificationSettings(),
          _buildDataUsageSettings(),
          _buildAccessibilitySettings(),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return SwitchListTile(
      title: Text('Notifications'),
      subtitle: Text('Enable or disable notifications'),
      value: _notificationsEnabled,
      onChanged: (value) {
        setState(() {
          _notificationsEnabled = value;
        });
      },
    );
  }

  Widget _buildDataUsageSettings() {
    return SwitchListTile(
      title: Text('Data Usage'),
      subtitle: Text('Enable or disable data usage'),
      value: _dataUsageEnabled,
      onChanged: (value) {
        setState(() {
          _dataUsageEnabled = value;
        });
      },
    );
  }

  Widget _buildAccessibilitySettings() {
    return ListTile(
      title: Text('Accessibility'),
      subtitle: Text('Select an option'),
      trailing: DropdownButton<int>(
        value: _selectedAccessibilityOption,
        onChanged: (value) {
          setState(() {
            _selectedAccessibilityOption = value ?? 0;
          });
        },
        items: _accessibilityOptions
            .asMap()
            .entries
            .map(
              (entry) => DropdownMenuItem<int>(
                value: entry.key,
                child: Text(entry.value),
              ),
            )
            .toList(),
      ),
    );
  }
}

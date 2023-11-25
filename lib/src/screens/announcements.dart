import 'package:flutter/material.dart';
import '../models/announcement.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

    static const routeName = '/announcements';

  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final List<Announcement> _announcements = [
    Announcement(
      title: 'Urgent Announcement',
      description: 'This is an urgent announcement.',
      category: 'Urgent',
      date: DateTime.now(),
    ),
    Announcement(
      title: 'Informational Announcement',
      description: 'This is an informational announcement.',
      category: 'Informational',
      date: DateTime.now(),
    ),
  ];

  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Urgent', 'Informational'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text('Filter by category:'),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _announcements.length,
              itemBuilder: (context, index) {
                Announcement announcement = _announcements[index];
                if (_selectedCategory != 'All' &&
                    announcement.category != _selectedCategory) {
                  return const SizedBox.shrink();
                }
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              announcement.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${announcement.date.month}/${announcement.date.day}/${announcement.date.year}',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          announcement.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to announcement details screen.
                          },
                          child: Text('Read more'),
                        ),
                      ],
                    ),
                  ),
                  borderOnForeground: announcement.category == 'Urgent',
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: announcement.category == 'Urgent'
                          ? Colors.red
                          : Colors.grey,
                      width: announcement.category == 'Urgent' ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

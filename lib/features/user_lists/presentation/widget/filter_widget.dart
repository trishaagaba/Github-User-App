import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final Function(String, String, int, int) onFilterChanged;

  const FilterWidget({super.key, required this.onFilterChanged});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}
  class _FilterWidgetState extends State<FilterWidget> {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _typeController = TextEditingController();
    int _followers = 0;
    int _following = 0;

    // final TextEditingController _followersController = TextEditingController();
    // final TextEditingController _followingController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'By name',
            ),
          ),
          TextField(
            controller: _typeController,
            decoration: const InputDecoration(
              labelText: 'By type',
            ),
          ),
          const SizedBox(height: 16.0),
          Column(
          children: [
          Row(
            children: [
              Text("Followers: {$_followers}"),
      Expanded(
      child: Slider(
                  value: _followers.toDouble(),
                  min: 0,
                  max: 1000,
                  divisions: 1000,
                  label: _followers.toString(),
                  onChanged: (value) {
                    setState(() {
                      _followers = value.toInt();
                    });
                  }),)

                   ],),
                   Row(
              children: [
              Text("Following: {$_following}"),
      Expanded(
      child: Slider(
                  value: _following.toDouble(),
                  min: 0,
                  max: 1000,
                  divisions: 1000,
                  label: _following.toString(),
                  onChanged: (value) {
                    setState(() {
                      _following = value.toInt();
                    });
                  }))
      ]
                  )
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              widget.onFilterChanged(
                  _nameController.text,
                  _typeController.text,
                  _followers,
                  _following
              );
              Navigator.of(context).pop();
            },
            child: const Text('Apply filters'),
          ),
        ],
      );
    }
  }




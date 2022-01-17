import 'package:flutter/material.dart';

class DownloadsTab extends StatefulWidget {
  const DownloadsTab({Key? key}) : super(key: key);

  @override
  _DownloadsTabState createState() => _DownloadsTabState();
}

class _DownloadsTabState extends State<DownloadsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Downloads'),
      ),
    );
  }
}

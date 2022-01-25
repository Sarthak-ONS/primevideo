import 'package:flutter/material.dart';
import 'package:prime_video/Services/download_movie.dart';
import 'package:prime_video/Services/permission_handler_api.dart';
import 'package:prime_video/prime_colors.dart';

class DownloadsTab extends StatefulWidget {
  const DownloadsTab({Key? key}) : super(key: key);

  @override
  _DownloadsTabState createState() => _DownloadsTabState();
}

class _DownloadsTabState extends State<DownloadsTab> {
  @override
  void initState() {
    PermissionHandlerAPi.checkPermissionStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PrimeColors.primaryColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: PrimeColors.primaryColor,
        elevation: 0,
        title: const Text('Downloads'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          shadows: [
            BoxShadow(
              color: PrimeColors.primaryBlueColor,
              offset: const Offset(0.5, 0.5),
            )
          ],
        ),
        leading: const Icon(Icons.download_done_outlined),
        iconTheme: IconThemeData(color: PrimeColors.primaryBlueColor),
        titleSpacing: 3.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              'Download feature will be implemented soon',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

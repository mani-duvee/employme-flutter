import 'package:flutter/material.dart';
import '../../http/GetApiCall.dart';
import '../../http/endpoints.dart';
import './bio.dart';
import './personalInfo.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final ValueNotifier<dynamic> profileNotifier = ValueNotifier<dynamic>(null);
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  @override
  void dispose() {
    profileNotifier.dispose();
    super.dispose();
  }

  void loadProfileData() {
    GetApiCalls.get(
      endpoint: EMPLOYEE_PROFILE,
      onLoadingStart: () => setState(() => loading = true),
      onLoadingEnd: () => setState(() => loading = false),
      responseNotifier: profileNotifier,
      showSuccessNotif: false,
      showFailedNotif: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ValueListenableBuilder<dynamic>(
        valueListenable: profileNotifier,
        builder: (context, responseData, child) {
          Map<String, dynamic>? profileData;

          if (responseData is Map && responseData['data'] is Map) {
            profileData = Map<String, dynamic>.from(responseData['data']);
          }

          if (loading && profileData == null) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Column(
            children: [
              Bio(profileData: profileData),
              PersonalInfo(profileData: profileData),
            ],
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../http/EmployeeStorage.dart';
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
    _fetchEmployerIdAndLoadProfile();
  }

  Future<void> _fetchEmployerIdAndLoadProfile() async {
    final employerId = await EmployeeStorage.getEmployerId();
    if (employerId != null && employerId.isNotEmpty) {
      loadProfileData(pathParams: {'employerId': employerId});
    } else {
      loadProfileData();
    }
  }

  @override
  void dispose() {
    profileNotifier.dispose();
    super.dispose();
  }

  void loadProfileData({Map<String, String>? pathParams}) {
    GetApiCalls.get(
      endpoint: EMPLOYEE_PROFILE,
      pathParams: pathParams,
      onLoadingStart: () {
        if (mounted) setState(() => loading = true);
      },
      onLoadingEnd: () {
        if (mounted) setState(() => loading = false);
      },
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
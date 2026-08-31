/// Central registry of all API endpoint URLs used by the app.
///
/// No HTTP method is stored here — since calls are already split by
/// method (PostApiCalls, GetApiCalls, PutApiCalls, DeleteApiCalls),
/// each file only ever uses its own verb.
class Endpoints {
  Endpoints._();

  // ---------------------------------------------------------------------
  // Auth API
  // ---------------------------------------------------------------------
  static const String EMPLOYEE_LOGINE = "employee/auth/login";
  static const String EMPLOYEE_PROFILE = "employer/profile/{employerId}";
}

// Top-level constants for direct access without Endpoints. prefix
const String EMPLOYEE_LOGINE = Endpoints.EMPLOYEE_LOGINE;
class ApiConstants {
  // static const String baseUrl = 'http://10.0.2.2:5054';
  static const String baseUrl = 'https://merodinapi.soft-acc.com';

  // static const String baseUrl = 'https://10.0.2.2:44319';
  // static const String baseUrl = 'http://202.51.74.36:9175';

  static const String generateToken = '/Users/GenerateToken';
  static const String signUp = '/Users/';
  static const String getTablWithOccupyStatus =
      '/api/v1/ResturantTables/GetTablWithOccupyStatus';
  static const String getTodayOrderCount =
      '/api/v1/ItemOrderMaster/GetTodayOrdersCount';
  static const String editCategory = '/api/v1/Category/';
  static const String getAllActiveCategories =
      '/api/v1/Category/GetAllActiveCategory';
  static const String getAllActiveProducts =
      '/api/v1/Product/GetAllActiveProducts';
  static const String getAllUserGroup = '/api/UserGroup';
  static const String changeOrderTable = '/api/v1/ItemOrderMaster/ChangeTable';
  static const String addTable = '/api/v1/ResturantTables';
  static const String getAllUserGroups = '/api/v1/UserGroups/GetAllUserGroups';
  static const String teamInfo = '/api/v1/TeamInfo';
  static const String getTeamInfo = '/api/v1/TeamInfo/GetAll';
  static const String getTeamMapInfo = '/api/v1/UserTeamMapInfo';
  static const String companyInfo = '/api/v1/CompanyInfo';
  static const String editCustomer = '/api/v1/Customer';
  static const String getUserEmail = '/Users/SearchUserViaEmail';
  static const String getCurrentTeamInfo =
      '/api/v1/UserTeamMapInfo/GetCurUserTeams';
  static const String approveRequest =
      '/api/v1/UserTeamMapInfo/ApproveRejectCancelTeamRequest';
  static const String getScheduleByDateRange =
      '/api/v1/ScheduleInfo/GetScheduleInfoByDateRange';
  static const String scheduleInfo = '/api/v1/ScheduleInfo';
  static const String getAllscheduleInfo = '/api/v1/ScheduleInfo/GetAll';
}

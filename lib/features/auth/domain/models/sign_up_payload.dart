class SignUpPayload {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String userGroupId;

  SignUpPayload({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userGroupId,
    required this.username,
    required this.password,
  });
}
// {
//   "id": 0,
//   "username": "string",
//   "firstName": "string",
//   "lastName": "string",
//   "email": "string",
//   "password": "string",
//   "userGroupId": 0,
//   "userGroupName": "string",
//   "userGroupCode": "string"
// }
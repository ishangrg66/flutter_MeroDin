abstract class UserSearchEvent {}

class FetchUserSuggestions extends UserSearchEvent {
  final String query;
  FetchUserSuggestions(this.query);
}

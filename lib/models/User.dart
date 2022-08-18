class MyUser {
  String username;
  String userEmail;
  String uID;
  String displayName;

  MyUser(this.username, this.userEmail, this.uID, this.displayName);
  String getUsername() => username;
  String getUserEmail() => userEmail;
  String getFirstName() => uID;
  String getLastName() => displayName;

  void setUsername(String username) {
    this.username = username;
  }

  void setUserEmail(String userEmail) {
    this.userEmail = userEmail;
  }

  void setFirstName(String uID) {
    this.uID = uID;
  }

  void setLastName(String displayName) {
    this.displayName = displayName;
  }
}

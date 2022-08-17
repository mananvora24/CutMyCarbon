class MailContent {
  String subject;
  String time;
  String sender;
  String message;

  MailContent(this.subject, this.sender, this.time, this.message);
  String getSubject() => subject;
  String getSender() => sender;
  String getTime() => time;
  String getMessage() => message;
}

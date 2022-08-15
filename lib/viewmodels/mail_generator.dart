import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cut_my_carbon/viewmodels/mail_content.dart';
import 'package:cut_my_carbon/viewmodels/shared_model.dart';

class MailGenerator extends SharedViewModel {
  MailGenerator();
  List<MailContent> mailList = [];
  //MailContent getMailContent(int position) => mailList[position];

  int mailListLength = 0;

  Future<List<MailContent>> getMail() async {
    await FirebaseFirestore.instance
        .collection('Mail')
        .orderBy('timestamp')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<dynamic> data = querySnapshot.docs;
      if (data.isEmpty) {
        print("Data is empty");
      }
      print("mail snapshot list: $data");
      for (var snapshot in data) {
        Map<String, dynamic>? mail = snapshot.data();
        String subject = mail!['subject'];
        String sender = mail['from'];
        Timestamp mailTime = mail['timestamp'] as Timestamp;
        String time = "${mailTime.toDate().month} ${mailTime.toDate().day}";
        String message = mail['body'];
        print("$subject, $sender, $time, $message");
        MailContent mailContent = MailContent(subject, sender, time, message);
      }
    });

    mailListLength = mailList.length;
    return mailList;
  }
}

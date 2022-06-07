class QuestionModal {
  String? uid;
  int? questionNo;
  String? question;
  String? comment;

  QuestionModal({this.uid, this.questionNo, this.question, this.comment});

  factory QuestionModal.fromMap(map) {
    return QuestionModal(
      uid: map['uid'],
      questionNo: map['questionNo'],
      question: map['question'],
      comment: map['comment'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'questionNo': questionNo,
      'question': question,
      'comment': comment
    };
  }
}


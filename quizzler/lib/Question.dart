class Question {

  String questionText = '';
  bool questionAns = false;

  Question(String q, bool ans)
  {
    this.questionAns = ans;
    this.questionText = q;
  }

}
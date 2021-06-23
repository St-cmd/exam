export class Question {
  constructor(title, answerA, answerB, answerC, answerD, rightAnswer, rate, category) {
    this.title = title
    this.answerList = [answerA,answerB,answerC,answerD],
    this.rightAnswer = rightAnswer
    this.rate = rate
    this.category = category
  }
}

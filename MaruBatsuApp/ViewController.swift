//
//  ViewController.swift
//  MaruBatsuApp
//
//  Created by 佐藤壮 on 2023/09/05.
//

import UIKit

struct Question {
    let questionText: String
    let isCorrectAnswer: Bool
}

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var currentQuestionNum: Int = 0
    var questions: [Question] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    func showQuestion() {
        if questions.isEmpty {
            questionLabel.text = "問題がありません"
        } else {
            let question = questions[currentQuestionNum]
            questionLabel.text = question.questionText
        }
    }
    
    func checkAnswer(yourAnswer: Bool) {
        if questions.isEmpty {
            showAlert(message: "問題がありません")
            return
        }
        let question = questions[currentQuestionNum]
        questionLabel.text = question.questionText
        
        if yourAnswer == question.isCorrectAnswer {
            currentQuestionNum += 1
            showAlert(message: "正解！！")
        } else {
            showAlert(message: "不正解...")
        }
        
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        showQuestion()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func createQuizButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        if let createQuestionVC = storyboard.instantiateViewController(withIdentifier: "addTableViewController") as? addTableViewController {
            createQuestionVC.onQuestionCreated = { [weak self] questionLabel,
                isCorrectAnswer in
                let newQuestion = Question(questionText: questionLabel, isCorrectAnswer: isCorrectAnswer)
                self?.questions.append(newQuestion)
                self?.showQuestion()
                self?.dismiss(animated: true, completion: nil)
            }
            createQuestionVC.onAllQuestionsDeleted = { [weak self] in
                self?.questions.removeAll()
                self?.showQuestion()
                self?.dismiss(animated: true, completion: nil)
            }
            self.present(createQuestionVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedNoButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: UIButton) {
        checkAnswer(yourAnswer: true)
    }
    
    
}


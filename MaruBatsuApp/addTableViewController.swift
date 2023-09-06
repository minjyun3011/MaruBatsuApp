//
//  addTableViewController.swift
//  MaruBatsuApp
//
//  Created by 佐藤壮 on 2023/09/06.
//

import UIKit

class addTableViewController: UIViewController {
    
    @IBOutlet weak var quizTextField: UITextField!
    @IBOutlet weak var answerSegmentedControl: UISegmentedControl!
    
    var onQuestionCreated: ((String,Bool) -> Void)?
    var onAllQuestionsDeleted: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func returnToTopButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveQuizButton(_ sender: UIButton) {
        guard let questionText = quizTextField.text,!questionText.isEmpty else {
            showAlert(message: "問題文を入力してください")
            return
        }
        
        let isCorrectAnswer = answerSegmentedControl.selectedSegmentIndex == 0
        
        onQuestionCreated?(questionText, isCorrectAnswer)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func removeButton(_ sender: UIButton) {
        showAlert(message: "問題をすべて削除しました")
        onAllQuestionsDeleted?()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}




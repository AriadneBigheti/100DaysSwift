//
//  ViewController.swift
//  Project2
//
//  Created by Ariadne Bigheti on 18/11/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(shareTapped))
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased())       SCORE: \(score)"
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        self.questionsAnswered += 1
        
        if sender.tag == correctAnswer{
            title = "Correct"
            score += 1
            if (score == 10){
                message = "Your final score is \(score)"
                score = 0
                questionsAnswered = 0
            }else{
                message = "Your score is \(score)"
            }
        }else{
            title = "Wrong"
            score -= 1
            message = "That's the flag of \(countries[sender.tag].uppercased())!"
        }
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(alert, animated: true)
        
    }
    
    @objc func shareTapped(){
        
        let alert = UIAlertController(title: "SCORE", message: "Your score is \(score)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
}


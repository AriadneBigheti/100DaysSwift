//
//  ViewController.swift
//  Project5
//
//  Created by Ariadne Bigheti on 30/11/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
            
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    @objc func startGame(){
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

    @objc func addAnswer(){
        let ac = UIAlertController(title: "Enter an answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){  [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submitAnswer(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submitAnswer(_ answer: String){
        let lowercasedAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(lowercasedAnswer){
            if isOriginal(lowercasedAnswer){
                if isReal(lowercasedAnswer){
                    usedWords.insert(lowercasedAnswer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                    
                }else{
                    errorTitle = "Word is not real"
                    errorMessage = "You can't make them up!"
                }
            }else{
                errorTitle = "Word already used"
                errorMessage = "Try a new one"
            }
        }else{
            errorTitle = "Word is not possible"
            errorMessage = "You can't make that word from \(title!.lowercased())"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    
    func isPossible(_ answer: String) -> Bool{
        guard var word = title?.lowercased() else { return false }
        
        for letter in answer{
            if let position = word.firstIndex(of: letter){
                word.remove(at: position)
            }else{
                return false
            }
        }
        return true

    }
    
    func isOriginal(_ answer: String) -> Bool{
        guard let title = title?.lowercased() else { return false }
        var isOriginal = true
        
        if (answer == title){
            isOriginal = false
            showErrorMessage(title: "Ops...", message: "You can't use the original word!")
        }else{
            isOriginal = !usedWords.contains(answer)
        }
        
        return isOriginal
    }
    
    func isReal (_ answer: String) -> Bool{
        var isReal = false
        
        if (answer.count < 3){
            isReal = false
            showErrorMessage(title: "Ops...", message: "The word needs to have more than 2 letters!")
        }
        else{
            
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: answer.utf16.count)
        let misspeledRange = checker.rangeOfMisspelledWord(in: answer, range: range, startingAt: 0, wrap: false, language: "en")
        
        isReal = misspeledRange.location == NSNotFound
        }
        
        return isReal
    }
    
    func showErrorMessage(title: String, message: String){
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    
}



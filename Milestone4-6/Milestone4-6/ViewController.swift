//
//  ViewController.swift
//  Milestone4-6
//
//  Created by Ariadne Bigheti on 17/01/22.
//

import UIKit

class ViewController: UITableViewController {
    
    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Shopping List"
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addItemToList))
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .refresh, target: self, action: #selector(clearList))
    }
    
    @objc func addItemToList (){
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let action = UIAlertAction(title: "Submit", style: .default){ [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else{
                return
            }
            self?.submitAnswer(answer)
        }
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc func clearList(){
        items.removeAll()
        tableView.reloadData()
    }
    
    func submitAnswer(_ answer: String){
        items.insert(answer, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
}


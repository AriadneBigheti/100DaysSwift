//
//  ViewController.swift
//  Milestone1-3
//
//  Created by Ariadne Bigheti on 21/11/21.
//

import UIKit

class ViewController: UITableViewController {
    var listOfImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Flag Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items{
            if item.hasSuffix("@3x.png"){
                listOfImages.append(item)
            }
        }
        print(listOfImages)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfImages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let image = listOfImages[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(image)")
        let title = image.components(separatedBy: "@")
        cell.textLabel?.text = title[0].uppercased()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            let title = listOfImages[indexPath.row].components(separatedBy: "@")
            vc.picture = listOfImages[indexPath.row]
            vc.title = title[0].uppercased()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}


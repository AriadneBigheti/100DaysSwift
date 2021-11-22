//
//  DetailViewController.swift
//  Milestone1-3
//
//  Created by Ariadne Bigheti on 21/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var picture: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = picture{
            imageView.image = UIImage(named: image)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tappedButton))
                
    }
   
    @objc func tappedButton(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.9) else{
            print("No image found")
            return
        }
                
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

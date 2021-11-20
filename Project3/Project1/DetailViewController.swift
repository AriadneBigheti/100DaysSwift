//
//  DetailViewController.swift
//  Project1
//
//  Created by Ariadne Bigheti on 15/11/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var numberOfImages : Int?
    var position : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let position = position{
            if let numberOfImages = numberOfImages {
            title = "Picture \(position) of \(numberOfImages)"
            }
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage{
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped(){
        guard let image = imageView.image?.jpegData(compressionQuality: 0.9) else{
            print("No image found")
            return
        }
        guard let text = selectedImage else{
            print("No text found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

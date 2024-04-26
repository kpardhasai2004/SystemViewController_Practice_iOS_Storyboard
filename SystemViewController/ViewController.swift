//
//  ViewController.swift
//  SystemViewController
//
//  Created by user2 on 29/01/24.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ShareButtonTapped(_ sender: UIButton) {
        guard let image = ImageView.image else {
            return
        }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender; present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func SafariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "https://www.apple.com"){
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func CameraButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
//        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in print("User selected Camera action")})
//        
//        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {action in print("User selected Photo Library action")})
//        
        alertController.addAction(cancelAction)
//        alertController.addAction(cameraAction)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        alertController.popoverPresentationController?.sourceView =  sender; present(alertController, animated: true, completion: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in imagePicker.sourceType = .camera; self.present(imagePicker,animated: true, completion: nil) })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary; self.present(imagePicker,animated: true, completion: nil) })
            alertController.addAction(photoLibraryAction)
        }
//        alertController.addAction(photoLibraryAction)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            return
        }
        ImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}


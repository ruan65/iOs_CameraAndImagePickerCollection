//
//  ViewController.swift
//  TakeAndSaveImagesApp
//
//  Created by a on 15/10/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    
    @IBOutlet weak var pickedImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickedImageView.backgroundColor = UIColor.blue
    }

    @IBAction func btnOpenCamera(_ sender: UIButton) {
        
        openCamera()
    }
    
    @objc private func openCamera() {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            print("Yes camera is avalable.....")
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            print("\(editedImage)")
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("\(originalImage)")
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            pickedImageView.image = selectedImage
        }
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        
    }
}


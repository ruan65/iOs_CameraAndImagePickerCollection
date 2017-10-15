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
        
        setupUi()
        
    }

    @IBAction func btnOpenCamera(_ sender: UIButton) {
        
        openCamera()
    }
    
    let photoCollectionView = PhotoCollectionView()
    
    func setupUi() {
        
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pickedImageView.backgroundColor = UIColor.blue
        
        view.addSubview(photoCollectionView)
        
        photoCollectionView.topAnchor.constraint(equalTo: pickedImageView.bottomAnchor).isActive = true
        photoCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        photoCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        photoCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true



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

class PhotoCollectionView: BaseUIView {
    
    var imagesCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.green
        
        cv.translatesAutoresizingMaskIntoConstraints = false

        return cv
    }()
    
    override func setupViews() {
        
        addSubview(imagesCollection)
        
        imagesCollection.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imagesCollection.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imagesCollection.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
}

class BaseUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
}




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
        photoCollectionView.leftAnchor.constraint(equalTo: pickedImageView.leftAnchor).isActive = true
        
        photoCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        photoCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true



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
            
            photoCollectionView.images.append(selectedImage)
            
            photoCollectionView.imagesCollection.reloadData()
        }
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        print("Canceled............")
    }
}

class PhotoCollectionView: BaseUIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var images = [UIImage]()
    
    var imagesCollection: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.green
        cv.translatesAutoresizingMaskIntoConstraints = false

        return cv
    }()
    
    override func setupViews() {
        
        imagesCollection.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.id)
        imagesCollection.delegate = self
        imagesCollection.dataSource = self
        
        addSubview(imagesCollection)
        
        imagesCollection.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imagesCollection.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imagesCollection.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.id, for: indexPath) as! ImageCell
        
        cell.imageView.image = images[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("clicked \(indexPath.item)")
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    func setupViews() {}
}

class ImageCell: BaseCell {
    
    static let id = "ImageCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.red
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        layer.masksToBounds = true
        addSubview(imageView)
        addConstraintsFillEntireView(view: imageView)
    }
}


extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
    
    func addConstraintsFillEntireView(view: UIView) {
        addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        addConstraintsWithFormat(format: "V:|[v0]|", views: view)
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




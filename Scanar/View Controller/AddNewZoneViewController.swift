//
//  AddNewZoneViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import UIKit

class AddNewZoneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    var choosenImage: UIImage?
    @IBOutlet var imageView: UIImageView!
       @IBOutlet var chooseBuuton: UIButton!
    var imagePicker: ImagePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    
    @IBAction func btnClicked(_ sender: UIButton) {

        self.imagePicker.present(from: sender)
        }

    
  

    
 
}

extension AddNewZoneViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
        self.choosenImage = image
    }
}

//
//  AddNewZoneViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import UIKit

class AddNewZoneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
   
    var choosenImage: UIImage?
    @IBOutlet var imageView: UIImageView!
       @IBOutlet var chooseBuuton: UIButton!

    var imagePicker: ImagePicker!
    

    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        textfield.delegate = self
        textFieldShouldReturn(textfield)
        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    
    @IBAction func btnClicked(_ sender: UIButton) {

        self.imagePicker.present(from: sender)
        }


    
    @IBAction func saveDidTap(_ sender: Any) {
    }
    
//MARK: - Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addRefToAsset" {
            let vc = segue.destination as! ChoosePopupViewController
            vc.refImage = choosenImage
            vc.zoneName = textfield.text!
         
            
            
        }
        
        
    }
}
//MARK: - Extensions
extension AddNewZoneViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
        self.choosenImage = image
    }
    
    
}

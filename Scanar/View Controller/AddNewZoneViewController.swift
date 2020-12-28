//
//  AddNewZoneViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import UIKit

class AddNewZoneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var senderTag: Int?
    var zoneID: String?
   
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var chooseBuuton: UIButton!
    @IBOutlet weak var imageView2: UIImageView!
    
    var isRefSelected = false
    var isAssSelected = false
    
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
    
    //MARK: -Buttons
    
    @IBAction func btnClicked(_ sender: UIButton) {
        self.senderTag = 0
        print(sender.tag)
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func btnClicked2(_ sender: UIButton) {
        self.senderTag = 1
        print(sender.tag)
        self.imagePicker.present(from: sender)
    }
    
    
    
    @IBAction func anchorClicked(_ sender: Any) {
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
        if segue.identifier == "objectToAnchor" {
            
            let vc = segue.destination as! AnchoringViewController
            vc.zoneID = zoneID
            vc.zoneName = textfield.text
            vc.refImage = imageView.image
            vc.assetImage = imageView2.image

            
            
            
            
            
        }
        
        
    }
    
    
}
//MARK: - Extensions
extension AddNewZoneViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        
               if self.senderTag == 0 {
                   //TROPHY 1
                   self.imageView.image = image
                   self.isRefSelected = true
               } else if self.senderTag == 1 {
                   //TROPHY 2
                   self.imageView2.image = image
                   self.isAssSelected = true
               }
    }
    
  
 

    
    
}

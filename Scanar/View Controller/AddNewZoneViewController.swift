//
//  AddNewZoneViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import UIKit
import UniformTypeIdentifiers

class AddNewZoneViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var senderTag: Int?
    var zoneID: String?
    var zoneName: String?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var chooseBuuton: UIButton!
    @IBOutlet weak var imageView2: UIImageView!
    
    var isRefSelected = false
    var isAssSelected = false
    
    var imagePicker: ImagePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    //MARK: -Buttons
    
    @IBAction func btnClicked(_ sender: UIButton) {
        self.senderTag = 0
        print(sender.tag)
        self.imagePicker.present(from: sender)
    }
    @IBAction func importObjectClicked(_ sender: Any) {
        let supportedTypes: [UTType] = [UTType.png,UTType.jpeg]
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        documentPicker.shouldShowFileExtensions = true
        self.present(documentPicker, animated: true, completion: nil)

        
    }
    
    @IBAction func btnClicked2(_ sender: UIButton) {
        self.senderTag = 1
        print(sender.tag)
        self.imagePicker.present(from: sender)
    }
    
    
    
    @IBAction func anchorClicked(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "objectToAnchor" {
            
            let vc = segue.destination as! AnchoringViewController
            vc.zoneID = zoneID
            vc.zoneName = zoneName
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




extension AddNewZoneViewController: UIDocumentPickerDelegate {
  
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
      
        let url = urls.first
       //let object = ...?
        print(url)
        
        
        controller.dismiss(animated: true)
    }
    
    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
}

//
//  ChoosePopupViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import UIKit

class ChoosePopupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var assetImage: UIImage?
    var refImage: UIImage?
    var imagePicker: ImagePicker!
    var zoneName: String = ""
    var zoneID: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        print(refImage)
        
       
    }
    
    
    @IBAction func btnClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
     @IBAction func saveClicked(_ sender: Any) {
      //performsegue ke anchor4
performSegue(withIdentifier: "saveToAnchor", sender: self)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveToAnchor" {
            let vc = segue.destination as! AnchoringViewController
            vc.zoneID = zoneID
            vc.zoneName = zoneName
            vc.assetImage = assetImage
            
            vc.refImage = refImage
            
            
           
            
            
        }
    }
}

//MARK: - Extensions
extension ChoosePopupViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
        self.assetImage = image
    }
    
    
}

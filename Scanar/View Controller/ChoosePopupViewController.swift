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
        print(zoneName)
    }
    

    @IBAction func btnClicked(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
     @IBAction func saveClicked(_ sender: Any) {
        var imageRefURL: [URL] = [URL]()
        var assetsURL: [URL] = [URL]()
        zoneID = GenerateUniqueCode()
        //just save 1 image
        
        imageRefURL.append(imageToURL(image: refImage!))
        
        //assetsURL is fake
        assetsURL.append(imageToURL(image: assetImage!))
        //Remove force unwrap and give UI warning if field is empty
        
        if isZoneAvailable(zoneIDToCheck: zoneID!) == true {
            
            uploadNewZone(zoneID: zoneID!, references: imageRefURL, zoneName: zoneName, assets: assetsURL)
            performSegue(withIdentifier: "saveToFinish", sender: self)
        } else {
            print("Zone ID duplicate available ")
        }

     }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveToFinish" {
            let vc = segue.destination as! SuccesViewController
            vc.zoneID = zoneID
            
            
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

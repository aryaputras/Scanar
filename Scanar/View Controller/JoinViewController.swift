//
//  JoinViewController.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 17/12/20.
//

import UIKit
import CoreData
import CloudKit





class JoinViewController: UIViewController, UITextFieldDelegate {
   
    var downloaded: [Downloaded] = []

    var zoneIDPassed: String?
  
    @IBOutlet weak var zoneIDLabel: UILabel!
    
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        textfield.delegate = self
        textFieldShouldReturn(textfield)
        
        
        
        //1
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<Downloaded>(entityName: "Downloaded")
        
        //3
        do {
          downloaded = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        /// Do any additional setup after loading the view.
    }
    


    @IBAction func joinClicked(_ sender: Any) {
        //ifzoneavailable == true = zone not exist
        
        joinZone(zoneID: zoneIDPassed ?? "")
        
       
        
        
        
    }
    
    //MARK: - Join functions
    func joinZone(zoneID: String){
        //init jvc
        
        //Query zone
        let database = CKContainer.default().publicCloudDatabase
        let predicate = NSPredicate(format: "zoneID == %@", zoneID)
        let query = CKQuery(recordType: "zone", predicate: predicate)
        print(zoneID)
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let fetchedRecords = records {
                
                var referenceAssets = fetchedRecords[0].object(forKey: "references") as! [CKAsset]
                var popupAssets = fetchedRecords[0].object(forKey: "assets") as! [CKAsset]
                
                var zoneIDString =
                    
                    
                    
                    fetchedRecords[0].object(forKey: "zoneID") as! String
                
               
                //assets belum di download
                let downloadedAssetsURLs = self.downloadFiles(ref: referenceAssets, zoneID: zoneIDString, ass: popupAssets)
                
                self.saveUrlToCoreData(refURL: downloadedAssetsURLs.ref, assURL: downloadedAssetsURLs.ass, zoneID: zoneIDString)
                
                //
                print("Join zone succesful")
                
                //Check di core data ada atau tidak filenya, kalo tidak baru query&download. kalo sudah ada langsung ambil dari local dir
                
                
            } else {
                print("Failed to join zone with error: ", error!)
            }
        }
        
    }
    func saveUrlToCoreData(refURL: [URL], assURL: [URL], zoneID: String){
        
       
        //Save url after downloading files to core data
        var objects: [NSManagedObject] = []
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        // 1
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
          NSEntityDescription.entity(forEntityName: "Downloaded",
                                     in: managedContext)!
        
        let object = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        object.setValue(refURL, forKeyPath: "references")
        object.setValue(assURL, forKey: "assets")
        object.setValue(zoneID, forKey: "zoneID")
        print(refURL)
        print(assURL)
        // 4
        do {
          try managedContext.save()
          objects.append(object)
            print("saveURL to core data sucesful")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func downloadFiles(ref: [CKAsset], zoneID: String, ass: [CKAsset]) -> (ref: [URL], ass: [URL]){
        
        //Dummy return
        var refURL: [URL] = []
        var assURL: [URL] = []
        //1. Bikin folder
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let docURL = URL(string: documentsDirectory)!
        let dataPath = docURL.appendingPathComponent(zoneID)
        
        if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
        
        
        
        //2. Looping dan masukin asset ke path satu satu
        
            ///downloading image reference
        for asset in ref {
            do {
                let imageData = try Data(contentsOf: (asset.fileURL!))
                
                //KALO FILE = image save as.png
                let destinationPath = NSURL(fileURLWithPath: dataPath.absoluteString).appendingPathComponent("reference-\(GenerateUniqueFileSuffix()).png", isDirectory: false)
                
                FileManager.default.createFile(atPath: destinationPath!.path, contents:imageData, attributes:nil)
                print("download references succesful")
                //print file size
                let resources = try destinationPath?.resourceValues(forKeys:[.fileSizeKey])
                let fileSize = resources?.fileSize!
                //append to [URL]
                refURL.append(destinationPath!)
                    print ("\(fileSize)")
                
               
            } catch {
                print(error.localizedDescription)
            }
        }
        
        
        ///downlloading assets belum
        for asset in ass {
            do {
                let imageData = try Data(contentsOf: (asset.fileURL!))
                //KALO FILE = image save as.png
                let destinationPath = NSURL(fileURLWithPath: dataPath.absoluteString).appendingPathComponent("assets-\(GenerateUniqueFileSuffix()).png", isDirectory: false)
                
                FileManager.default.createFile(atPath: destinationPath!.path, contents:imageData, attributes:nil)
                print("download assets succesful")
                //print file size
                let resources = try destinationPath?.resourceValues(forKeys:[.fileSizeKey])
                let fileSize = resources?.fileSize!
                    print ("\(fileSize)")
                
                assURL.append(destinationPath!)
            } catch {
                print(error.localizedDescription)
            }
        }

       
     return (refURL, assURL)
    }
    
    
    
 
    
   
//MARK: - Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        zoneIDPassed = textField.text
        self.view.endEditing(true)
        return false
    }
    
    func initializeHideKeyboard(){
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
     
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
   
        view.endEditing(true)
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? ScannerViewController,
                segue.identifier == "homeToContainer" {
                vc.delegate = self
            }
        
        if let vc = segue.destination as? ARViewController,
            segue.identifier == "goToAR" {
            vc.idOfZone = zoneIDPassed
            print(zoneIDPassed)
           
        }
        
        }
    }

extension JoinViewController:ChildToParentProtocol {
    func needToPassInfoToParent(with value: String) {
        zoneIDPassed = value
    }
    
   }


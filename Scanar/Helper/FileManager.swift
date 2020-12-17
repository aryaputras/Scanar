//
//  FileManager.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import Foundation
import CloudKit
import UIKit


//return url
//atau bikin model aja biar tau yg mana file berkaitan sama siapa
func downloadFiles(ref: [CKAsset], zoneID: String, ass: [CKAsset]){
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
        } catch {
            print(error.localizedDescription)
        }
    }

    
 
}


func imageToURL(image: UIImage) -> URL{
    
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    let docURL = URL(fileURLWithPath: documentsDirectory)
    let dataPath = docURL.appendingPathComponent("cache\(GenerateUniqueFileSuffix()).jpg")
   
    if !FileManager.default.fileExists(atPath: dataPath.absoluteString) {
        do {
            try image.jpegData(compressionQuality: 0.8)?.write(to: dataPath.absoluteURL)
            print("created file")
        } catch {
            print("error creating file")
        }
    }
    
    return dataPath.absoluteURL
}




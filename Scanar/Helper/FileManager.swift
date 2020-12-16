//
//  FileManager.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import Foundation
import CloudKit
import UIKit

func downloadFiles(ref: [CKAsset], zoneID: String){
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
            
            let destinationPath = NSURL(fileURLWithPath: dataPath.absoluteString).appendingPathComponent("reference-\(GenerateUniqueFileSuffix()).png", isDirectory: false)
            
            FileManager.default.createFile(atPath: destinationPath!.path, contents:imageData, attributes:nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    ///downlloading assets belum

    
    
 
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




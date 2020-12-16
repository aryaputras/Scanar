//
//  FileManager.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import Foundation
import CloudKit

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
            
            let destinationPath = NSURL(fileURLWithPath: dataPath.absoluteString).appendingPathComponent("\(GenerateRandom()).png", isDirectory: false)
            
            FileManager.default.createFile(atPath: destinationPath!.path, contents:imageData, attributes:nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    ///downlloading assets belum
    
    
 
}




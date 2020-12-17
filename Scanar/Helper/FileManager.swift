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




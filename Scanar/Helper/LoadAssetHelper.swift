//
//  LoadAsset.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 26/02/21.
//

import Foundation
import UIKit
import SceneKit
import SceneKit.ModelIO

enum SupportedFileType {
    case image
    case object
    case unknown
}


func getFileType(url: URL) -> SupportedFileType{
    let ext = NSURL(fileURLWithPath: url.absoluteString).pathExtension
    //check is this is path or URL
    var result: SupportedFileType = .unknown
   
    
    print(ext)
    switch ext {
    
    case "jpg":
        result = .image
    case "png":
        result = .image
        
    case "obj":
        result = .object
    case "usdz":
        result = .object
    case "dae":
        result = .object
    
    default:
        print("unknown type")
    }
    
    //check if the  the result is still unknown on changed
    return result
}


func loadImageFrom(url: URL, completionHandler:@escaping(UIImage)->()) {
    DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    print("LOADED IMAGE");
                    completionHandler(image);
                }
            }
        }
    }
}



func loadObjectFrom(url: URL, completionHandler:@escaping(SCNScene)->()) {
    let asset = MDLAsset(url: url)
    let scene = SCNScene(mdlAsset: asset)
    DispatchQueue.global().async {
        print("LOADED OBJECT")
        completionHandler(scene)
    }
}


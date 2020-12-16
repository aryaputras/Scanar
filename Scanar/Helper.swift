//
//  Helper.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 15/12/20.
//

import UIKit
import Foundation

var zonesData = ["ACX321"]


//MARK: -Generator

func GenerateRandom()->String{
    //Generate
    let length = 6
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
     var s = ""
     for _ in 0 ..< length {
         s.append(letters.randomElement()!)
     }
     return s
    //If already exist, regenerate another
}




func GenerateUniqueCode() -> String{
    var result: String
    var unique = GenerateRandom()
    if zonesData.contains(unique){
        result = GenerateRandom()
        print("generated new one")
    } else {
        result = unique
        print("appended")
    }
    return result
}




func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)

    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)

        if let output = filter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
        }
    }

    return nil
}



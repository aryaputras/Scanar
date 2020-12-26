//
//  Helper.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 15/12/20.
//

import UIKit
import Foundation
import SceneKit


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

func GenerateUniqueFileSuffix()->String{
    //Generate
    let length = 4
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


func convertV3ToDouble(vector: SCNVector3) -> [Double]{
    var result: [Double] = []
    result.append(Double(vector.x))
    result.append(Double(vector.y))
    result.append(Double(vector.z))
    
    return result
}



func convertV4ToDouble(vector: SCNVector4) -> [Double]{
    var result: [Double] = []
    result.append(Double(vector.x))
    result.append(Double(vector.y))
    result.append(Double(vector.z))
    result.append(Double(vector.w))
    
    return result
}


func convertDoubleToV3(doubles: [Double]) -> SCNVector3{
    let result: SCNVector3 = SCNVector3(doubles[0], doubles[1], doubles[2])
    print("cek kebalik ngak ya?")
    return result
}


func convertDoubleToV4(doubles: [Double]) -> SCNVector4{
    let result: SCNVector4 = SCNVector4(doubles[0], doubles[1], doubles[2], doubles[3])
    print("cek kebalik ngak ya?")
    return result
}




func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
    let context = CIContext(options: nil)
    if context != nil {
        return context.createCGImage(inputImage, from: inputImage.extent)
    }
    return nil
}





func convertTextToSCNText(text: String) -> SCNText {
    let scntext = SCNText(string: text, extrusionDepth: 2)
    let material = SCNMaterial()
    material.diffuse.contents = UIColor.magenta
    scntext.materials = [material]
    
    
    
    //node.geometry = this scntext return value
    return scntext
}

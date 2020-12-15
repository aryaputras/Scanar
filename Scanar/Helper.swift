//
//  Helper.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 15/12/20.
//

import Foundation

var Zones = ["ACX321"]
func GenerateUniqueRandom()->String{
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

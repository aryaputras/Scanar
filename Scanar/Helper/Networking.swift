//
//  Networking.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import Foundation
import CloudKit



//MARK: - Save

func uploadNewZone(zoneID: String, references: [URL], zoneName: String, assets: [URL], position: [Double], rotation: [Double] ){
    //config
    let database = CKContainer.default().publicCloudDatabase
    let newRecord = CKRecord(recordType: "zone")
    
    //Setup assets
    var ref = [CKAsset]()
    var ass = [CKAsset]()
    
    
    for asset in references{
        let assetURL = CKAsset(fileURL: asset.absoluteURL)
        ref.append(assetURL)
    }
    for asset in assets{
        let assetURL = CKAsset(fileURL: asset.absoluteURL)
        ass.append(assetURL)
    }
    
    //Things to write
    let zoneIDRecordValue = zoneID as CKRecordValue
    let zoneNameRecordValue = zoneName as CKRecordValue
    let refRecordValue = ref as CKRecordValue
    let assRecordValue = ass as CKRecordValue
    let positionRecordValue = position as CKRecordValue
    let rotationRecordValue = rotation as CKRecordValue
    
    
    //set value
    newRecord.setObject(zoneIDRecordValue, forKey: "zoneID")
    newRecord.setObject(zoneNameRecordValue, forKey: "zoneName")
    newRecord.setValue(refRecordValue, forKey: "references")
    newRecord.setValue(assRecordValue, forKey: "assets")
    newRecord.setValue(position, forKey: "position")
    newRecord.setValue(position, forKey: "rotation")
    //SETVALUE ASSETS
    
    //operation
    database.save(newRecord) { (record, error) in
        
        if error != nil {
            print(error?.localizedDescription)
        } else {
            print("write new zone succesful")
        }
    }
}

//THIS FUNCTION DOES NOT WORK .!
func isZoneAvailable(zoneIDToCheck: String) -> Bool{
    //Check if zone with such ID exist or not.
    var result: Bool = true
    
    let database = CKContainer.default().publicCloudDatabase
    let predicate = NSPredicate(format: "zoneID == %@", zoneIDToCheck)
    let query = CKQuery(recordType: "zone", predicate: predicate)
    database.perform(query, inZoneWith: nil) { (record, error) in
        if let fetchedRecords = record {
            
            
            
            if fetchedRecords.count == 0 {
                print(fetchedRecords.count)
                result = true
            } else {
                print(fetchedRecords)
                result = false
            }
            
        }
    }
    //is this method effective?
    
    //Query blm selesai udh return true
    return result
}




//MARK: - Query





//
//  Networking.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 16/12/20.
//

import Foundation
import CloudKit



//MARK: - Save

func uploadNewZone(zoneID: String, references: [URL], zoneName: String, assets: [URL] ){
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
    
    
    //set value
    newRecord.setObject(zoneIDRecordValue, forKey: "zoneID")
    newRecord.setObject(zoneNameRecordValue, forKey: "zoneName")
    newRecord.setObject(refRecordValue, forKey: "references")
    newRecord.setObject(assRecordValue, forKey: "assets")
    
    //operation
    database.save(newRecord) { (record, error) in
        if error != nil {
            print("error write operation")
        } else {
            print("write new zone succesful")
        }
    }
}


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
    
    //Query blm selesai udh return false
    return result
}




//MARK: - Query

func joinZone(zoneID: String){
    //Query zone
    let database = CKContainer.default().publicCloudDatabase
    let predicate = NSPredicate(format: "zoneID == \(zoneID)")
    let query = CKQuery(recordType: "zone", predicate: predicate)
    
    database.perform(query, inZoneWith: nil) { (records, error) in
        if let fetchedRecords = records {
            
            var referenceAssets = fetchedRecords[0].object(forKey: "references") as! [CKAsset]
            
            var zoneIDString =
                
                
                
                fetchedRecords[0].object(forKey: "zoneID") as! String
            
            
            //assets belum di download
            downloadFiles(ref: referenceAssets, zoneID: zoneIDString)
            //
            print("Join zone succesful")
            
            //Check di core data ada atau tidak filenya, kalo tidak baru query&download. kalo sudah ada langsung ambil dari local dir
            
            
        } else {
            print("Failed to join zone with error: ", error!)
        }
    }
    
}



//
//  Downloaded+CoreDataProperties.swift
//  Scanar
//
//  Created by Abigail Aryaputra Sudarman on 18/12/20.
//
//

import Foundation
import CoreData


extension Downloaded {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Downloaded> {
        return NSFetchRequest<Downloaded>(entityName: "Downloaded")
    }

    @NSManaged public var assets: NSObject?
    @NSManaged public var references: NSObject?

}

extension Downloaded : Identifiable {

}

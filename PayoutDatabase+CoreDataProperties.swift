//
//  PayoutDatabase+CoreDataProperties.swift
//  IOS-Assignment-1-SlotMachine
//
//  Created by Krisuv Bohara on 2023-02-19.
//
//

import Foundation
import CoreData


extension PayoutDatabase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PayoutDatabase> {
        return NSFetchRequest<PayoutDatabase>(entityName: "PayoutDatabase")
    }

    @NSManaged public var date: String?
    @NSManaged public var payout: String?
    @NSManaged public var pay: Int16

}

extension PayoutDatabase : Identifiable {

}

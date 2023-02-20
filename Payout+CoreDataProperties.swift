//
//  Payout+CoreDataProperties.swift
//  IOS-Assignment-1-SlotMachine
//
//  Created by Krisuv Bohara on 2023-02-19.
//
//

import Foundation
import CoreData


extension Payout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payout> {
        return NSFetchRequest<Payout>(entityName: "Payout")
    }

    @NSManaged public var date: String?
    @NSManaged public var payout: String

}

extension Payout : Identifiable {

}

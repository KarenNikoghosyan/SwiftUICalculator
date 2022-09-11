//
//  History+CoreDataProperties.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 05/09/2022.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var inputText: String?
    @NSManaged public var calculatedText: String?

}

extension History : Identifiable {

}

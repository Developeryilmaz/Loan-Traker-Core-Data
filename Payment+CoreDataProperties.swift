//
//  Payment+CoreDataProperties.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 3.06.2023.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var id: String?
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var loan: Loan?
    
    public var wrappedDate: Date {
        date ?? Date()
    }

}

extension Payment : Identifiable {

}

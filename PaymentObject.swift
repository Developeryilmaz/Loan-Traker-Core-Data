//
//  PaymentObject.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import Foundation

struct PaymentObject: Equatable {
    var sectionName: String
    var sectionObjects: [Payment]
    var sectionTotal: Double
}

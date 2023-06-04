//
//  File.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import Foundation

enum Destination: Hashable {
    case payment(Loan)
    case addPayment(Loan, Payment? = nil)
}

//
//  Date+Extension.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import Foundation

extension Date {
    var intOfYear: Int? {
        Calendar.current.dateComponents([.year], from: self).year
    }
}

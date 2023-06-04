//
//  Loan_Traker_Core_DataApp.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 3.06.2023.
//

import SwiftUI

@main
struct Loan_Traker_Core_DataApp: App {

    var body: some Scene {
        WindowGroup {
            AllLoansView()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}

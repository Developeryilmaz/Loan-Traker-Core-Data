//
//  AddLoanViewModel.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 3.06.2023.
//

import Foundation

final class AddLoanViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var amount = ""
    @Published var startDate = Date()
    @Published var dueDate = Date()
    
    func isInvalidForm() -> Bool {
        name.isEmpty || amount.isEmpty
    }
    
    func saveLoan() {
        let loan = Loan(context: PersistenceController.shared.viewContext)
        loan.id = UUID().uuidString
        loan.name = name
        loan.totalAmaount = Double(amount) ?? 0.0
        loan.startDate = startDate
        loan.dueDate = dueDate
        
        PersistenceController.shared.save()
    }
    
//    func createdLoan() {
//        for i in 1...25 {
//            let loan = Loan(context: PersistenceController.shared.viewContext)
//            loan.id = UUID().uuidString
//            loan.name = "name \(i)"
//            loan.totalAmaount = (Double(amount) ?? 0.0) + Double(i)
//            loan.startDate = startDate
//            loan.dueDate = dueDate
//            
//            PersistenceController.shared.save()
//        }
//    }
    
}

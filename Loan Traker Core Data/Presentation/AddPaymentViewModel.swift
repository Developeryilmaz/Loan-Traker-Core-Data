//
//  AddPaymentViewModel.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import Foundation

final class AddPaymentViewModel: ObservableObject {
    
    @Published var amount = ""
    @Published var date = Date()
    private var loan: Loan?
    private var payment: Payment?
    
    func setLoanObject(loan: Loan) {
        self.loan = loan
    }
    
    func setPaymentObject(payment: Payment?) {
        self.payment = payment
    }
    
    func isInvalidForm() -> Bool {
        amount.isEmpty
    }
    
    func savePayment() {
        payment != nil ? updatePayment() : createdNewPayment()
    }
    
    private func createdNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0.0
        newPayment.date = date
        newPayment.loan = loan
        
        PersistenceController.shared.save()
    }
    
    private func updatePayment() {
        guard let payment = payment else { return }
        payment.amount = Double(amount) ?? 0.0
        payment.date = date
        PersistenceController.shared.save()
    }
    
    func setupEditView() {
        guard let payment = payment else { return }
        amount = "\(payment.amount)"
        date = payment.wrappedDate
    }
}

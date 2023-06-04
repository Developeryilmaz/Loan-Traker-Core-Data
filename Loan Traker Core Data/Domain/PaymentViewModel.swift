//
//  File.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import Foundation
import SwiftUI


final class PaymentViewModel: ObservableObject {
    
    @Published private(set) var expectedToFinishOn: String = ""
    @Published private(set) var progress = Progress()
    @Published private(set) var allPayments: [Payment] = []
    @Published private(set) var allPaymentObjects: [PaymentObject] = []
    
    private var loan: Loan?
    
    func setLoanObject(loan: Loan) {
        self.loan = loan
        setPayments()
    }
    
    private func setPayments() {
        guard loan != nil else { return }
        allPayments = loan?.paymentArray ?? []
    }
    
    func calculateProgress() {
        guard let loan = loan else { return }
        let totalPaid = allPayments.reduce(0, { $0 + $1.amount})
        let totalLeft = loan.totalAmaount - totalPaid
        let value = totalPaid / loan.totalAmaount
        
        progress = Progress(value: value, leftAmount: totalLeft, paidAmaount: totalPaid)
    }
    
    func calculateDays() {
        guard let loan = loan else { return }
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        let totalDays = Calendar.current.dateComponents([.day], from: loan.wrapperStartDate, to: loan.wrappedDueDate).day ?? 0
        let passedDays = Calendar.current.dateComponents([.day], from: loan.wrapperStartDate, to: Date()).day
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }
        let didPayPerDay = totalPaid / Double(passedDays ?? Int(0.0))
        let shouldPayPerDay = loan.totalAmaount / Double(totalDays)
        if shouldPayPerDay < didPayPerDay {
            
        } else {
            
        }
        let daysLeftToFinish = (loan.totalAmaount - totalPaid) / didPayPerDay
        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())
        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
        }
        expectedToFinishOn = "Expected to finish by \(newDate.formatted(date: .long, time: .omitted))"
    }
    
    func deleteItem(paymentObject: PaymentObject, index: IndexSet) {
        guard let deleteIndex = index.first else { return }
        let paymentToDelete = paymentObject.sectionObjects[deleteIndex]
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        setPayments()
        withAnimation {
            calculateProgress()
            calculateDays()
        }
        separateByYear()
    }
    
    func separateByYear() {
        allPaymentObjects = []
        
        let dict = Dictionary(grouping: allPayments, by: { $0.wrappedDate.intOfYear })
        for (key, value) in dict {
            guard let key = key else { return }
            let total = value.reduce(0) { $0 + $1.amount}
            allPaymentObjects.append(PaymentObject(sectionName: "\(key)", sectionObjects: value.reversed(), sectionTotal: total))
        }
        allPaymentObjects.sort { $0.sectionName > $1.sectionName }
    }
    

}

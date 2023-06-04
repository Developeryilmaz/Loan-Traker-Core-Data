//
//  AddPaymentView.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import SwiftUI

struct AddPaymentView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddPaymentViewModel()
    
    var loan: Loan
    var payment: Payment?
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button {
            viewModel.savePayment()
            dismiss()
        } label: {
            Text("Done")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isInvalidForm())
    }
    
    
    var body: some View {
        Form {
            TextField("Amount", text: $viewModel.amount)
                .keyboardType(.numberPad)
            DatePicker("Date", selection: $viewModel.date, in: Date()..., displayedComponents: .date)
        }
        .navigationTitle(payment != nil ? "Edit Payment" : "Add Payment")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                saveButton()
            }
        }
        .onAppear {
            viewModel.setLoanObject(loan: loan)
            viewModel.setPaymentObject(payment: payment)
            viewModel.setupEditView()
        }
    }
}

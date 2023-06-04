//
//  PaymentsView.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import SwiftUI

struct PaymentsView: View {
    
    @StateObject private var viewModel = PaymentViewModel()
    
    var loan: Loan
    
    @ViewBuilder
    private func addButton() -> some View {
        NavigationLink(value: Destination.addPayment(loan
                                                    )) {
            Image(systemName: "plus.circle")
                .font(.title3)
                .padding([.vertical, .leading], 5)
        }
    }
    
    @ViewBuilder
    private func progressView() -> some View {
        VStack {
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            
            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal)
            
            Text(viewModel.expectedToFinishOn)
        }
    }
    
    var body: some View {
        VStack {
            if !viewModel.allPaymentObjects.isEmpty {
                progressView()
            }
            List {
                ForEach(viewModel.allPaymentObjects, id: \.sectionName) { paymentObject in
                    Section(header: Text("\(paymentObject.sectionName) - \(paymentObject.sectionTotal, format: .currency(code: "USD"))")) {
                        ForEach(paymentObject.sectionObjects) { payment in
                            NavigationLink(value: Destination.addPayment(loan, payment)) {
                                PaymentCell(amaount: payment.amount, date: payment.wrappedDate)
                            }
                        }
                        .onDelete { index in
                            viewModel.deleteItem(paymentObject: paymentObject, index: index)
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
        .navigationTitle(loan.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                addButton()
            }
        }
        .onAppear {
            viewModel.setLoanObject(loan: loan)
            viewModel.calculateProgress()
            viewModel.calculateDays()
            viewModel.separateByYear()
        }
    }
}

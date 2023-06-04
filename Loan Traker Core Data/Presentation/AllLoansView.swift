//
//  ContentView.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 3.06.2023.
//

import SwiftUI
import CoreData

struct AllLoansView: View {
    
    @StateObject var viewModel = AddLoanViewModel()
    @Environment(\.managedObjectContext) var viewContext
    @State private var isAddLoanShowing: Bool = false
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)], animation: .default)
    private var loans: FetchedResults<Loan>
    
    @ViewBuilder
    private func addButton() -> some View {
        Button {
            isAddLoanShowing = true
        } label: {
            Image(systemName: "plus.circle")
                .font(.title3)
                .padding([.vertical, .leading], 5)
        }
        
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(loans) { loan in
                    NavigationLink(value: Destination.payment(loan)) {
                        LoanCell(name: loan.wrappedName, amaount: loan.totalAmaount, date: loan.wrappedDueDate)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("All loans")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton()
                }
            }
            .sheet(isPresented: $isAddLoanShowing) {
                AddLoanView()
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .addPayment(let loan, let payment):
                    AddPaymentView(loan: loan, payment: payment)
                case .payment(let loan):
                    PaymentsView(loan: loan)
                }
            }
        }
    }
    
    func deleteItems(offset: IndexSet) {
        withAnimation {
            offset.map { loans[$0] }.forEach(viewContext.delete)
            PersistenceController.shared
                
                .save()
        }
    }
} 

struct AllLoansView_Previews: PreviewProvider {
    static var previews: some View {
        AllLoansView()
    }
}


/*
 
 struct AllLoansView: View {
 
 @StateObject var viewModel = AddLoanViewModel()
 @Environment(\.managedObjectContext) var viewContext
 @State private var isAddLoanShowing: Bool = false
 @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Loan.totalAmaount, ascending: false)], animation: .default)
 private var loans: FetchedResults<Loan>
 
 @ViewBuilder
 private func addButton() -> some View {
 Button {
 isAddLoanShowing = true
 } label: {
 Image(systemName: "plus.circle")
 .font(.title3)
 .padding([.vertical, .leading], 5)
 }
 
 }
 
 var body: some View {
 NavigationStack {
 if loans.isEmpty {
 VStack {
 ProgressView()
 .onAppear {
 viewModel.createdLoan()
 }
 }
 } else {
 List {
 ForEach(loans) { loan in
 Text("\(loan.wrappedName  )")
 Text("\(loan.totalAmaount)")
 }
 }
 .navigationTitle("All loans")
 .toolbar {
 ToolbarItem(placement: .navigationBarTrailing) {
 addButton()
 }
 }
 .sheet(isPresented: $isAddLoanShowing) {
 AddLoanView()
 }
 }
 
 }
 }
 }
 
 struct AllLoansView_Previews: PreviewProvider {
 static var previews: some View {
 AllLoansView()
 }
 }
 
 */

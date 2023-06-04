//
//  AddLoanView.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 3.06.2023.
//

import SwiftUI

struct AddLoanView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddLoanViewModel()
    

    @ViewBuilder
    private func cancelButton() -> some View {
        Button {
            dismiss()
        } label: {
            Text("Cacel")
                .font(.subheadline)
                .fontWeight(.semibold)
        }

    }
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button {
            viewModel.saveLoan()
            dismiss()
        } label: {
            Text("Done")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isInvalidForm())
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $viewModel.name)
                        .autocapitalization(.sentences)
                    TextField("Amount", text: $viewModel.amount)
                        .keyboardType(.numberPad)
                    DatePicker("Start Date", selection: $viewModel.startDate, in: ...Date(), displayedComponents: .date)
                    DatePicker("Due Date", selection: $viewModel.dueDate, in: viewModel.startDate..., displayedComponents: .date)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton()
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    saveButton()
                }
            }
        }
    }
}

struct AddLoanView_Previews: PreviewProvider {
    static var previews: some View {
        AddLoanView()
    }
}

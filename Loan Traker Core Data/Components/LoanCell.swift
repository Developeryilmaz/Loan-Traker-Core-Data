//
//  LoanCell.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import SwiftUI

struct LoanCell: View {
    let name: String
    let amaount: Double
    let date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.headline)
                    .fontWeight(.semibold)
                Text(amaount, format: .currency(code:  "USD"))
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            Spacer()
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .fontWeight(.light)
        }
    }
}

struct LoanCell_Previews: PreviewProvider {
    static var previews: some View {
        LoanCell(name: "Test Loan", amaount: 100, date: Date())
    }
}

//
//  PaymentCell.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import SwiftUI

struct PaymentCell: View {
    let amaount: Double
    let date: Date
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(amaount, format: .currency(code: "USD"))
                .font(.headline)
                .fontWeight(.semibold)
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct PaymentCell_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCell(amaount: 4500.0, date: Date())
    }
}

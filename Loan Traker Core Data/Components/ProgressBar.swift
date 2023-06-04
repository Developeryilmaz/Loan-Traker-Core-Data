//
//  ProgressBar.swift
//  Loan Traker Core Data
//
//  Created by YILMAZ ER on 4.06.2023.
//

import SwiftUI



struct ProgressBar: View {
    
    private let progress: Progress
    private let barHeigt: CGFloat
    
    init(progress: Progress, barHeight: CGFloat = 20.0) {
        self.progress = progress
        self.barHeigt = barHeight
    }
    
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Text(progress.leftAmount, format: .currency(code: "USD"))
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: min(CGFloat(progress.value) * proxy.size.width, proxy.size.width), height: proxy.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
                    Text(progress.paidAmaount, format: .currency(code: "USD"))
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
            .cornerRadius(45)
        }
        .frame(height: barHeigt)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: Progress(), barHeight: 25)
    }
}

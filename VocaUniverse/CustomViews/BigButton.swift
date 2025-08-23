//
//  BigButton.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

struct BigButton: View {
    let buttonTitle: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 353, height: 74)
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.23, green: 0.01, blue: 0.84), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.12, green: 0, blue: 0.44), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.98, y: 0.86),
                    endPoint: UnitPoint(x: 0.3, y: 0.27)
                )
            )
            .cornerRadius(10)
            .overlay(
                Text(buttonTitle)
                    .font(.vu(.black, size: 30))
                  .kerning(8)
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                  .frame(width: 352, height: 74, alignment: .center)
            )
    }
}


#Preview {
    BigButton(buttonTitle: "START")
        .padding()
}

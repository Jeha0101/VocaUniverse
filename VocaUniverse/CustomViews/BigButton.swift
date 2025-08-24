//
//  BigButton.swift
//  VocaUniverse
//
//  Created by Jini on 8/24/25.
//

import SwiftUI

struct BigButton: View {
    let buttonTitle: String
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 353, height: 74)
            .background(Color(hex: "#15177D"))
            .cornerRadius(10)
            .overlay(
                Text(buttonTitle)
                    .font(.vu(.black, size: 30))
                  .kerning(12)
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                  .frame(width: 352, height: 74, alignment: .center)
            )
    }
}


#Preview {
    //BigButton(buttonTitle: "START")
    //    .padding()
}

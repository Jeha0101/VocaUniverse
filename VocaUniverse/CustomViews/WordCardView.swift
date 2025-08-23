//
//  WordCardView.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

struct WordCardView: View {
    let word: String
    let example: String
    let textColor: String = "#181956"
    
    var body: some View {
        VStack(spacing: 12) {
            Text(word)
                .font(.vu(.black, size: 60))
                .tracking(0.5)
                .foregroundStyle(Color(hex: textColor))
                .minimumScaleFactor(0.6)
                .lineLimit(1)
            
            Text(example)
                .font(.vu(.semibold, size: 12))
                .foregroundStyle(Color(hex: textColor))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 10)
        }
        .frame(minHeight: 210)
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
    }
}

#Preview {
    WordCardView(word: "Apple", example: "I ate an apple for breakfast, and it was crisp and sweet.")
}

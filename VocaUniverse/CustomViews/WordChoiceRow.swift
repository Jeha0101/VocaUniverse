//
//  WordChoiceRow.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

struct WordChoiceRow: View {
    let title: String
    var borderStyle: ChoiceBorderStyle = .none
    var action: () -> Void
    
    // 색 정의
    private var selectedGreen: Color { Color(hex: "#2E8FB9") }
    private var wrongRed: Color { Color(hex: "B94C1D") }
    
    var strokeColor: Color? {
        switch borderStyle {
        case .none:    return nil
        case .selected, .correct: return selectedGreen
        case .wrong:   return wrongRed
        }
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 30, weight: .black))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 74, alignment: .center)
                .background(.white.opacity(0.3))
                .cornerRadius(10)
                .overlay {
                    if let stroke = strokeColor {
                        RoundedRectangle(cornerRadius: 10)
                            .inset(by: 2.5)
                            .stroke(stroke, lineWidth: 5)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}


//
//  SegmentedProgressBar.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

struct SegmentedProgressBar: View {
    let totalSteps: Int
    let currentStep: Int
    
    var separatorWidth: CGFloat = 4
    private let radius: CGFloat = 7
    private let backgroundColor = Color.white.opacity(0.2)
    private let filledOverlay   = Color(hex: "#F1A94D")
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            let gaps = max(totalSteps - 1, 0)
            let usableWidth = max(width - CGFloat(gaps) * separatorWidth, 0)
            let segmentWidth = (totalSteps > 0) ? usableWidth / CGFloat(totalSteps) : 0
            let clampedStep = max(0, min(currentStep, totalSteps))
            
            ZStack(alignment: .leading) {
                // Track
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(backgroundColor)

                HStack(spacing: separatorWidth) {
                    ForEach(0..<max(currentStep, 1), id: \.self) { step in
                        if step == 0 {
                            UnevenRoundedRectangle(cornerRadii: .init(
                                topLeading: radius, bottomLeading: radius,
                                bottomTrailing: 0, topTrailing: 0
                            ))
                            .fill(filledOverlay)
                            .frame(width: segmentWidth)
                        } else if step == totalSteps - 1 {
                            UnevenRoundedRectangle(cornerRadii: .init(
                                topLeading: 0, bottomLeading: 0,
                                bottomTrailing: radius, topTrailing: radius
                            ))
                            .fill(filledOverlay)
                            .frame(width: segmentWidth)
                        } else {
                            Rectangle()
                                .fill(filledOverlay)
                                .frame(width: segmentWidth)
                        }
                        
                    }
                }
            }
        }
        .frame(height: 14)
    }
}

#Preview {
    SegmentedProgressBar(totalSteps: 5, currentStep: 3)
}

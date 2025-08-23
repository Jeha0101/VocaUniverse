//
//  VocaView.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

// MARK: - Main Quiz View
struct VocaView: View {
    // 수정 필요
    let word: String
    let example: String
    let choices: [String]
    let correctIndex: Int
    let step: Int
    let totalSteps: Int = 5
    
    @State private var selectedIndex: Int? = nil
    @State private var evaluated: Bool = false
    
    private let backgroundImage = "VocaViewBackground"
    private let catImage = "WowCatHooray"
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                // Top bar: Close + progress
                HStack {
                    Button {
                        // 닫기 동작 (필요 시 바인딩/환경 dismiss로 연결)
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.trailing, 16)
                    }
                    
                    SegmentedProgressBar(
                        totalSteps: totalSteps,
                        currentStep: step
                    )
                    .frame(height: 14)
                }
                .padding(.horizontal, 20)
                .padding(.top, 44)
                .padding(.bottom, 13)
                
                VStack(spacing: 26) {
                    // Word Card
                    WordCardView(
                        word: word,
                        example: example
                    )
                    .padding(.horizontal, 20)
                    
                    // Choices
                    VStack(spacing: 20) {
                        ForEach(choices.indices, id: \.self) { idx in
                            let style = borderStyle(for: idx)
                            WordChoiceRow(
                                title: choices[idx],
                                borderStyle: style
                            ) {
                                selectedIndex = idx
                                evaluated = true
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 230)
                }
                
                Spacer()
            }
            
            // Bottom cat
            Image(catImage)
                .resizable()
                .scaledToFit()
                .frame(height: 233)
                .accessibilityHidden(true)
                .padding(.bottom, 0)
        }
    }
    
    private func borderStyle(for index: Int) -> ChoiceBorderStyle {
        guard evaluated, let selected = selectedIndex else {
            return (selectedIndex == index) ? .selected : .none
        }
        if selected == correctIndex {
            // 맞췄을 때: 선택지는 초록, 그 외는 none
            return (index == selected) ? .correct : .none
        } else {
            // 틀렸을 때: 선택한 건 빨강, 정답은 초록
            if index == selected { return .wrong }
            if index == correctIndex { return .correct }
            return .none
        }
    }
}

// MARK: - Preview
#Preview {
    VocaView(
        word: "Apple",
        example: "I ate an apple for breakfast, and it was crisp and sweet.",
        choices: ["사과", "복숭아", "수박"],
        correctIndex: 0,
        step: 5
    )
}

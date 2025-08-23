//
//  VocaView.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

// MARK: - Main Quiz View
struct VocaView: View {

    let wordList: [WordModel]
    
    @State private var currentIndex: Int = 0
    @State private var selectedIndex: Int? = nil
    @State private var evaluated: Bool = false
    @State private var currentChoices: [String] = []
    
    
    private var totalSteps: Int = 5
    private var currentWord: WordModel {
        wordList[currentIndex]
    }
    
    private let backgroundImage = "VocaViewBackground"
    private let catImage = "WowCatHooray"
    
//    // 현재 단어의 선택지 배열
//    private var choices: [String] {
//        [currentWord.meanKor, currentWord.option1, currentWord.option2]
//    }
    
    // 정답 인덱스
    private var correctIndex: Int {
        currentChoices.firstIndex(of: currentWord.meanKor) ?? 0
    }
    
    init(wordList: [WordModel], step: Int = 1) {
        self.wordList = wordList
        self.totalSteps = wordList.count
        self._currentIndex = State(initialValue: step - 1)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 40)
                
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
                        currentStep: currentIndex + 1
                    )
                    .frame(height: 14)
                }
                .padding(.horizontal, 20)
                .padding(.top, 44)
                .padding(.bottom, 13)
                
                VStack(spacing: 26) {
                    // Word Card
                    WordCardView(
                        word: currentWord.wordEng,
                        example: currentWord.exampleEng
                    )
                    .padding(.horizontal, 20)
                    
                    // Choices
                    VStack(spacing: 20) {
                        ForEach(currentChoices.indices, id: \.self) { idx in
                            let style = borderStyle(for: idx)
                            WordChoiceRow(
                                title: currentChoices[idx],
                                borderStyle: style
                            ) {
                                selectedIndex = idx
                                evaluated = true
                                
                                // 다음 문제로 이동
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                    moveToNextWord()
                                }
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
        .onAppear {
            setupChoices() // 처음 보여질 때 초기화
        }
        .toolbar(.hidden, for: .navigationBar)
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
    
    private func moveToNextWord() {
        evaluated = false
        selectedIndex = nil
        if currentIndex < wordList.count - 1 {
            currentIndex += 1
            setupChoices()
        } else {
            // 마지막 단어면 종료 처리
            print("모든 단어 완료!")
        }
    }
    
    private func setupChoices() {
        currentChoices = [currentWord.meanKor, currentWord.option1, currentWord.option2].shuffled()
    }
}

// MARK: - Preview
#Preview {
//    VocaView(
//        wordModel: WordModel(
//            wordEng: "Apple",
//            meanKor: "사과",
//            exampleEng: "I ate an apple for breakfast, and it was crisp and sweet.",
//            exampleKor: "나는 아침에 사과를 먹었고, 아주 아삭하고 달콤했다.",
//            isDone: false,
//            option1: "복숭아",
//            option2: "수박"
//        ),
//        step: 1
//    )
}

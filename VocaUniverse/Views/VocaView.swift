//
//  VocaView.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI
import SwiftData

// MARK: - Main Quiz View
struct VocaView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let wordList: [WordModel]
    
    @Binding var goToQuiz: Bool
    @Binding var goToStar: Bool
    
    @State private var goToFinish: Bool = false
    //@State private var goToVocaList: Bool = false
    
    @State private var currentIndex: Int = 0
    @State private var selectedIndex: Int? = nil
    @State private var evaluated: Bool = false
    @State private var currentChoices: [String] = []
    @State private var correctCount = 0
    
    
    private var totalSteps: Int = 5
    private var currentWord: WordModel {
        wordList[currentIndex]
    }
    
    private let backgroundImage = "VocaViewBackground"
    private let catImage = "WowCatHooray"
    
    // 정답 인덱스
    private var correctIndex: Int {
        currentChoices.firstIndex(of: currentWord.meanKor) ?? 0
    }
    
    init(wordList: [WordModel], goToQuiz: Binding<Bool>, goToStar: Binding<Bool>, step: Int = 1) {
        self.wordList = wordList
        self.totalSteps = wordList.count
        self._goToQuiz = goToQuiz
        self._goToStar = goToStar
        self._currentIndex = State(initialValue: step - 1)
    }
    
    var body: some View {
        ZStack {
            if goToFinish {
                FinishView(count: correctCount) {
                    withAnimation {
                        goToFinish = false
                        goToQuiz = false
                        goToStar = false
                    }
                }
                    .transition(.opacity)
                    
            } else {
                quizview
                    .transition(.opacity)
            }
            
        }
        .animation(.easeInOut(duration: 0.5), value: goToFinish)
    }
    
    var quizview: some View {
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
                        dismiss()
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
                    WordCardView(
                        word: currentWord.wordEng,
                        example: currentWord.exampleEng
                    )
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 20) {
                        ForEach(currentChoices.indices, id: \.self) { idx in
                            let style = borderStyle(for: idx)
                            WordChoiceRow(
                                title: currentChoices[idx],
                                borderStyle: style
                            ) {
                                if !evaluated { // 중복 클릭 방지
                                       selectedIndex = idx
                                       evaluated = true
                                       

                                    if idx == correctIndex {
                                        // 정답일 때 완료 처리
                                        currentWord.isDone = true
                                        correctCount += 1
                                        do {
                                            try modelContext.save()
                                            print("저장 성공: \(currentWord.wordEng)")
                                        } catch {
                                            print("저장 실패: \(error)")
                                        }
                                    }
                                       
                                    // 다음 문제로 이동
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                        moveToNextWord()
                                    }
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
            setupChoices()
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
            updateStarProgress()
            withAnimation {
                goToFinish = true
            }
            print("모든 단어 완료!")
        }
    }
    
    private func setupChoices() {
        currentChoices = [currentWord.meanKor, currentWord.option1, currentWord.option2].shuffled()
    }
    
    private func updateStarProgress() {
        guard let starName = wordList.first?.star else {
            print("Star 이름을 찾을 수 없음")
            return
        }

        // 동일한 star를 가진 단어들 전체를 쿼리
        let descriptor = FetchDescriptor<WordModel>(
            predicate: #Predicate { $0.star == starName }
        )

        guard let allWordsForStar = try? modelContext.fetch(descriptor),
              let star = getStarForCurrentQuiz() else {
            print("Star 또는 단어 목록을 찾을 수 없음")
            return
        }

        let doneCount = allWordsForStar.filter { $0.isDone }.count
        let totalCount = allWordsForStar.count

        star.progress = totalCount > 0 ? Double(doneCount) / Double(totalCount) : 0

        do {
            try modelContext.save()
            print("진행도 저장 완료: \(star.progress)")
            print("=== Star Progress Update ===")
            print("Star: \(starName)")
            print("완료 단어: \(doneCount), 전체 단어: \(totalCount)")
            print("새 진행도: \(Double(doneCount) / Double(totalCount))")
        } catch {
            print("진행도 저장 실패: \(error)")
        }
    }

    
    private func getStarForCurrentQuiz() -> StarModel? {
        guard let starName = wordList.first?.star else { return nil }

        let descriptor = FetchDescriptor<StarModel>(
            predicate: #Predicate { $0.title == starName }
        )

        return try? modelContext.fetch(descriptor).first
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

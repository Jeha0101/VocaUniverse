//
//  StarView.swift
//  VocaUniverse
//
//  Created by Jini on 8/24/25.
//

import SwiftUI
import SwiftData

struct StarView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var goToStar: Bool
    
    @State private var goToQuiz: Bool = false
    @State private var goToVocaList: Bool = false
    
    let stars: [StarModel]
    let starName: Int
    
    var quizTitle: String = "QUIZ"
    var vocaTitle: String = "VOCA"
    
    let mainViewBackground = "MainViewBackground"
    let starsBackground = "StarsBackground"
    let hill = "Hill"
    let wowCatLying  = "WowCatLying"
    
    var body: some View {
        ZStack {
            if goToVocaList {
                VocaListView(goToVocaList: $goToVocaList, goToStar: $goToStar, stars: stars, starName: starName)
                    .transition(.opacity)
                
            } else {
                starview
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: goToQuiz)
    }
    
    var starview: some View {
        ZStack(alignment: .top) {
            
            Image(mainViewBackground)
                .resizable()
                .ignoresSafeArea()
            Image(starsBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image(hill)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 379)
            }
            
            
            VStack(spacing: 0) {
                CustomToolBar(
                    showXMark: true,
                    xAction: {withAnimation {
                        goToStar = false
                    }},
                    title: stars[starName].title)
                
                Spacer().frame(maxHeight: 110)
                
                Image(stars[starName].title)
                    .resizable()
                    .frame(width: 280, height: 280)
                
                Spacer().frame(maxHeight: 140)
                
                NavigationLink(destination: VocaView(wordList: stars[starName].words, goToQuiz: $goToQuiz, goToStar: $goToStar)) {
                    BigButtonLabel(buttonTitle: quizTitle)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 14)
                }
                Button(action: {
                    goToVocaList = true
                }) {
                    BigButtonLabel(buttonTitle: vocaTitle)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
    }
}


private struct StarViewPreviewWrapper: View {
    @State private var goToStar: Bool = true
    
    // 샘플 스타 데이터 (words는 비워도 OK)
    private let stars: [StarModel] = [
        StarModel(title: "Level 1", words: [], progress: 0),
        StarModel(title: "Level 2", words: [], progress: 50)
    ]
    
    var body: some View {
        StarView(goToStar: $goToStar, stars: stars, starName: 0)
    }
}

// MARK: Preview
#Preview("StarView") {
    StarViewPreviewWrapper()
    // SwiftData 프리뷰용 in-memory 컨테이너
        .modelContainer(for: [StarModel.self, WordModel.self], inMemory: true)
}

//
//  HomeView.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI
import SwiftData

// MARK: - Main View
struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var stars: [StarModel]
    
    @State private var goToStar: Bool = false
    @State private var selectedStarIndex: Int? = nil
    
    var title: String = "Choose one of the planets"
    //var buttonTitle: String = "START"
    
    let mainViewBackground = "MainViewBackground"
    let starsBackground = "StarsBackground"
    let hill = "Hill"
    let wowCatLying  = "WowCatLying"
    
    
    
    var body: some View {
        ZStack {
            if goToStar, let index = selectedStarIndex {
                StarView(goToStar: $goToStar, stars: stars, starName: index)
                    .transition(.opacity)
            } else {
                mainview
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: goToStar)
        
    }
    
    var mainview: some View {
        ZStack(alignment: .top) {
            // Background
            Image(mainViewBackground)
                .resizable()
                .ignoresSafeArea()
            Image(starsBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 45){
                Spacer()
                
                HStack(spacing: 90) {
                    starButton(imageName: "GRE prep", index: 0, size: CGSize(width: 45, height: 45))
                    starButton(imageName: "TOEFL", index: 5, size: CGSize(width: 80, height: 80))
                        .offset(x: 40, y: 15)
                }
                
                HStack(spacing: 62) {
                    starButton(imageName: "Highschool Voca", index: 1, size: CGSize(width: 49, height: 49))
                        .offset(x: -25)
                    starButton(imageName: "Merriam Webster", index: 3, size: CGSize(width: 59, height: 59))
                        .offset(y: -40)
                    starButton(imageName: "Word Power", index: 8, size: CGSize(width: 50, height: 50))
                        .offset(x: -20, y: 25)
                }
                
                starButton(imageName: "Reading and Vocabulary", index: 4, size: CGSize(width: 46, height: 46))
                    .offset(x: -80)
                
                HStack(spacing: 74) {
                    starButton(imageName: "Vocabulary 22000 Ⅱ", index: 7, size: CGSize(width: 69, height: 69))
                    starButton(imageName: "Vocabulary 22000", index: 6, size: CGSize(width: 51, height: 51))
                        .offset(x: 35, y: -50)
                    starButton(imageName: "Instant Vocabulary", index: 2, size: CGSize(width: 80, height: 80))
                }
                .padding(.bottom, 300)
                
                
            }
            
            
            VStack {
                Spacer()
                Image(hill)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 379)
            }
            
            VStack {
                Spacer()
                Image(wowCatLying)
                    .resizable()
                    .frame(width: 212, height: 212)
                    .padding(.bottom, 145)
            }
            
            VStack(spacing: 0) {
                TitleBadge(text: title)
                    .padding(.top, 80)
                    .padding(.horizontal, 76)
                
                Spacer(minLength: 0)
                
                //                NavigationLink(destination: StarView(stars: stars) {
                //                    BigButton(buttonTitle: buttonTitle)
                //                        .padding(.horizontal, 20)
                //                        .padding(.bottom, 40)
                //                }
            }
        }
        .onAppear {
            print("=== 저장된 StarModel 데이터 ===")
            for star in stars {
                print("⭐️ Star Title: \(star.title)")
                print("   ID: \(star.id)")
                print("   Progress: \(star.progress)")
                print("   단어 개수: \(star.words.count)")
                
                // 단어 상세 출력
                for (index, word) in star.words.enumerated() {
                    print("""
                          \(index + 1). \(word.wordEng)
                             의미: \(word.meanKor)
                             예문(ENG): \(word.exampleEng)
                             예문(KOR): \(word.exampleKor)
                          """)
                }
                print("---------------------------")
            }
        }
    }
    
    // 별 버튼 생성 함수
    private func starButton(imageName: String, index: Int, size: CGSize) -> some View {
        Button {
            withAnimation {
                selectedStarIndex = index
                goToStar = true
            }
        } label: {
            Image(imageName)
                .resizable()
                .frame(width: size.width, height: size.height)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
}

// MARK: - Preview
#Preview {
    MainView()
}

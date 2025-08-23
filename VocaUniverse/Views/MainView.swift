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
    
    var title: String = "Choose one of the planets"
    var buttonTitle: String = "START"
    
    let mainViewBackground = "MainViewBackground"
    let starsBackground = "StarsBackground"
    let hill = "Hill"
    let wowCatLying  = "WowCatLying"
    
    var body: some View {
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
                    NavigationLink(destination: StarView(stars: stars, starName: 0)) {
                        Image("GRE prep")
                            .resizable()
                            .frame(width: 45, height: 45)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    NavigationLink(destination: StarView(stars: stars, starName: 5)) {
                        Image("TOEFL")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x: 40, y: 15)
                }
                
                HStack(spacing: 62) {
                    NavigationLink(destination: StarView(stars: stars, starName: 1)) {
                        Image("Highschool Voca")
                            .resizable()
                            .frame(width: 49, height: 49)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x: -25)
                    
                    NavigationLink(destination: StarView(stars: stars, starName: 3)) {
                        Image("Merriam Webster")
                            .resizable()
                            .frame(width: 59, height: 59)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(y: -40)
                    
                    NavigationLink(destination: StarView(stars: stars, starName: 8)) {
                        Image("Word Power")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x: -20, y: 25)
                }
                
                NavigationLink(destination: StarView(stars: stars, starName: 4)) {
                    Image("Reading and Vocabulary")
                        .resizable()
                        .frame(width: 46, height: 46)
                }
                .buttonStyle(PlainButtonStyle())
                .offset(x: -80)
                
                HStack(spacing: 74) {
                    NavigationLink(destination: StarView(stars: stars, starName: 7)) {
                        Image("Vocabulary 22000 Ⅱ")
                            .resizable()
                            .frame(width: 69, height: 69)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: StarView(stars: stars, starName: 6)) {
                        Image("Vocabulary 22000")
                            .resizable()
                            .frame(width: 51, height: 51)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .offset(x: 35, y: -50)
                    
                    NavigationLink(destination: StarView(stars: stars, starName: 2)) {
                        Image("Instant Vocabulary")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.bottom, 300)

                
                //Spacer()
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
}

// MARK: - Preview
#Preview {
    MainView()
}

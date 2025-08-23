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
            if goToQuiz {
                VocaView(wordList: stars[starName].words, goToQuiz: $goToQuiz, goToStar: $goToStar)
                    .transition(.opacity)
                    
            } else {
                starview
                    .transition(.opacity)
            }
            
        }
        .animation(.easeInOut(duration: 0.5), value: goToQuiz)
        //.animation(.easeInOut(duration: 0.5))
        
//        ZStack(alignment: .top) {
//            
//            Image(mainViewBackground)
//                .resizable()
//                .ignoresSafeArea()
//            Image(starsBackground)
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//            
//
//            VStack(spacing: 0) {
//                Spacer().frame(height: 40)
//                
//                TitleBadge(text: stars[starName].title)
//                    .padding(.top, 80)
//                    .padding(.horizontal, 109)
//                
//                Spacer(minLength: 0)
//                
//                Image(stars[starName].title)
//                    .resizable()
//                    .frame(width: 280, height: 280)
//                
//                Spacer()
//                
//                NavigationLink(destination: VocaView(wordList: stars[starName].words)) {
//                    BigButton(buttonTitle: quizTitle)
//                        .padding(.horizontal, 20)
//                        .padding(.bottom, 14)
//                }
//                
//                
//                BigButton(buttonTitle: vocaTitle)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, 40)
//                
//                //Spacer().frame(height: 40)
//            }
//            .padding(.bottom, 100)
//            //.toolbar(.hidden, for: .navigationBar)
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
                

                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    
                    ZStack {
                        Button {
                            withAnimation {
                                goToStar = false
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.trailing, 16)
                        }
                        .padding(.top, 80)
                                     .offset(x: -160)
                        
                        TitleBadge(text: stars[starName].title)
                            .padding(.top, 80)
                            .padding(.horizontal, 109)
                        
                    }
                    
                    Spacer(minLength: 0)
                    
                    Image(stars[starName].title)
                        .resizable()
                        .frame(width: 280, height: 280)
                    
                    Spacer().frame(height: 140)
                    
                    NavigationLink(destination: VocaView(wordList: stars[starName].words, goToQuiz: $goToQuiz, goToStar: $goToStar)) {
                        BigButtonLabel(buttonTitle: quizTitle)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 14)
                    }
                    
                    BigButtonLabel(buttonTitle: vocaTitle)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    
                    //Spacer().frame(height: 40)
                }
                .padding(.bottom, 100)
                //.toolbar(.hidden, for: .navigationBar)
            }
    }
}

#Preview {
    //tarView(stars: <#[StarModel]#>, title: "ddd")
}

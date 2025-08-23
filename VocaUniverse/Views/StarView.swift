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
    let stars: [StarModel]
    
    let starName: Int
    var quizTitle: String = "QUIZ"
    var vocaTitle: String = "VOCA"
    
    let mainViewBackground = "MainViewBackground"
    let starsBackground = "StarsBackground"
    let hill = "Hill"
    let wowCatLying  = "WowCatLying"
    
    var body: some View {
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
                
                TitleBadge(text: stars[starName].title)
                    .padding(.top, 80)
                    .padding(.horizontal, 109)
                
                Spacer(minLength: 0)
                
                Image(stars[starName].title)
                    .resizable()
                    .frame(width: 280, height: 280)
                
                Spacer()
                
                NavigationLink(destination: VocaView(wordList: stars[starName].words)) {
                    BigButton(buttonTitle: quizTitle)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 14)
                }
                
                
                BigButton(buttonTitle: vocaTitle)
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

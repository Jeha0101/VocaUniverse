//
//  FinishView.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

struct FinishView: View {
    // 맞춘 문제 개수 받아오기
    var count: Int
    var buttonTitle: String = "CHECK"
    
    let mainViewBackground = "MainViewBackground"
    let starsBackground = "StarsBackground"
    let hill = "Hill"
    let wowCat = "WowCat"
    let star = "Star"
    
    private var solvedCount: SolvedCount {
            let clamped = min(max(count, 1), 5)
            return SolvedCount(intValue: clamped)! // 1~5 보장되므로 강제 언랩 안전
        }
        private var solvedCountImageName: String { solvedCount.imageName }
    
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
            
            ZStack {
                Image(star)
                    .resizable()
                    .scaledToFit()
                    .frame(height:271)
                
                Image(solvedCountImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 110)
            }
            .padding(.top, 93)
            
            VStack {
                Spacer()
                Image(hill)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 379)
            }

            VStack {
                Spacer()
                Image(wowCat)
                    .resizable()
                    .frame(width: 392, height: 392)
                    .padding(.bottom, 145)
            }
            
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                
                StartButton(buttonTitle: buttonTitle)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                
            }
        }
    }
    
}

#Preview{
    FinishView(count: 1)
}

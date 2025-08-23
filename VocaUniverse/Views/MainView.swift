//
//  HomeView.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

// MARK: - Main View
struct CollectStarsView: View {
    var title: String = "Collect the stars"
    var buttonTitle: String = "Start"
    
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
            
            VStack {
                Spacer()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 379)
                    .background(
                        Image(hill)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 379)
                    )
            }

            VStack {
                Spacer()
                Image(wowCatLying)
                    .resizable()
                    .frame(width: 166, height: 166)
                    .padding(.bottom, 145)
            }
            
            VStack(spacing: 0) {
                TitleBadge(text: title)
                    .padding(.top, 80)
                    .padding(.horizontal, 109)
                
                Spacer(minLength: 0)
                
                StartButton(buttonTitle: buttonTitle)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CollectStarsView()
}

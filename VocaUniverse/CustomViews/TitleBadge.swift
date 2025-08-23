//
//  TitleBadge.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

struct TitleBadge: View {
    let text: String
    
    var body: some View {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 175, height: 40)
          .background(.white.opacity(0.3))
          .cornerRadius(23)
          .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
          .overlay(
            Text("Collect the stars")
              .font(
                //Todo - 폰트 수정
                Font.custom("SF Pro", size: 16)
                  .weight(.semibold)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.white)
          )
    }
}

#Preview {
    TitleBadge(text: "Collect the stars")
        .padding()
}

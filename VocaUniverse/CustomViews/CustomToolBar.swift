//
//  CustomToolBar.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/24/25.
//

import SwiftUI

struct CustomToolBar: View {
    var showXMark: Bool = false
    let xAction: () -> Void
    let title : String

    var body: some View {
        HStack {
            if showXMark {
                Button(action: xAction) {
                    Image(systemName: "xmark")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                }
                .padding(.top, 60)
                .padding(.leading, 20)
            }
            else {
                Image(systemName: "xmark")
                    .font(.system(size: 22, weight: .bold))
                    .opacity(0) // 균형 유지를 위한 빈 영역
            }
            Spacer()
            TitleBadge(text: title)
                .padding(.top, 60)
            Spacer()

            Image(systemName: "xmark")
                .font(.system(size: 22, weight: .bold))
                .opacity(0)
        }
    }
}

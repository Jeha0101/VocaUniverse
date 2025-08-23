//
//  LockRackView.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/24/25.
//

import SwiftUI
import WidgetKit

struct LockRectView: View {
    let entry: VocaEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.word)
                .font(.headline.weight(.bold))
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(entry.meaning)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}

//
//  Reviews.swift
//  Reviews
//
//  Created by 제하맥 on 8/24/25.
//
// Reviews.swift (Target: Reviews - Widget Extension)
import WidgetKit
import SwiftUI

struct Reviews: Widget {
    let kind = "Reviews"

    var body: some WidgetConfiguration {
        // 사용자 설정 불필요 → StaticConfiguration가 간단
        StaticConfiguration(kind: kind, provider: VocaProvider()) { entry in
            LockRectView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("오늘의 오답")
        .description("최근 틀린 단어 중 하나를 랜덤으로 보여줍니다.")
        .supportedFamilies([.accessoryRectangular]) // 잠금화면 직사각형만
    }
}

// 미리보기
#Preview(as: .accessoryRectangular) {
    Reviews()
} timeline: {
    VocaEntry(date: .now, word: "abase", meaning: "낮추다, 창피를 주다")
    VocaEntry(date: .now, word: "gregarious", meaning: "사교적인")
    VocaEntry(date: .now, word: "No mistakes 🎉", meaning: "오늘의 오답이 없습니다")
}

//
//  ReviewsProvider.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/24/25.
//

import WidgetKit
import SwiftUI

/// 위젯에 전달되는 1개 시점의 데이터
struct VocaEntry: TimelineEntry {
    let date: Date
    let word: String
    let meaning: String
}

/// 30분마다 랜덤 오답을 공급하는 Provider
struct VocaProvider: TimelineProvider {
    private let store = WrongWordsStore()
    
    func placeholder(in context: Context) -> VocaEntry {
        VocaEntry(date: .now,
                  word: "abase",
                  meaning: "낮추다, 창피를 주다"
                  )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (VocaEntry) -> Void) {
        completion(makeEntry())
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<VocaEntry>) -> Void) {
        let entry = makeEntry()
        let refresh = Calendar.current.date(byAdding: .minute, value: 30, to: .now) ?? .now.addingTimeInterval(1800)
        completion(Timeline(entries: [entry], policy: .after(refresh)))
    }
    
    // MARK: - Helpers
    private func makeEntry() -> VocaEntry {
        let list = store.fetchAll()
        if let pick = list.randomElement() {
            return VocaEntry(date: .now,
                             word: pick.word,
                             meaning: pick.meaning
                             )
        } else {
            // 비어있을 때 플레이스홀더
            return VocaEntry(date: .now,
                             word: "No mistakes 🎉",
                             meaning: "오늘의 오답이 없습니다"
                             )
        }
    }
}

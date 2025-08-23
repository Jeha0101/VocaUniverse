//
//  WidgetUpdater.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/24/25.
//

import Foundation
import WidgetKit

struct WidgetUpdater {
    static func onStudyFinished(wrongWords: [WrongWord]) {
        let store = WrongWordsStore()
        store.replaceAll(wrongWords)

        WidgetCenter.shared.reloadTimelines(ofKind: "Reviews")
    }
}

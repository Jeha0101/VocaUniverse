//
//  WrongWordsStore.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/24/25.
//

import Foundation

public struct WrongWord: Codable, Hashable {
    public let word: String
    public let meaning: String
    public let addedAt: Date

    public init(word: String, meaning: String, addedAt: Date = .now) {
        self.word = word
        self.meaning = meaning
        self.addedAt = addedAt
    }
}

public final class WrongWordsStore {
    private let suiteName = "group.name.jehaHwang.VocaUniverse" // App Group ID
    private let key = "wrong_words"

    private var defaults: UserDefaults? {
        UserDefaults(suiteName: suiteName)
    }

    public init() {}

    public func fetchAll() -> [WrongWord] {
        if let data = defaults?.data(forKey: key),
           let list = try? JSONDecoder().decode([WrongWord].self, from: data),
               !list.isEmpty {
                return list
            }

            return [
                WrongWord(word: "apple",  meaning: "사과"),
                WrongWord(word: "orange", meaning: "오렌지"),
                WrongWord(word: "manage", meaning: "관리하다")
            ]
    }

    public func save(_ list: [WrongWord], limit: Int = 200) {
        guard let data = try? JSONEncoder().encode(list) else { return }
        defaults?.set(data, forKey: key)
    }

    public func append(_ item: WrongWord) {
        var list = fetchAll()
        list.append(item)
        save(list)
    }

    public func replaceAll(_ list: [WrongWord]) {
        save(list)
    }
}

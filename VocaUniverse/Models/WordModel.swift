//
//  WordModel.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import Foundation
import SwiftData

///영단어 데이터 모델
@Model
final class WordModel {
    @Attribute(.unique) var id: UUID
    var wordEng: String
    var meanKor: String

    
    init(id: UUID = UUID(), wordEng: String, meanKor: String) {
        self.id = id
        self.wordEng = wordEng
        self.meanKor = meanKor
    }
}

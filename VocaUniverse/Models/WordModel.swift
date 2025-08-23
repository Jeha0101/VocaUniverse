//
//  WordModel.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import Foundation
import SwiftData

//영단어 데이터 모델
@Model
final class WordModel {
    @Attribute(.unique) var id: UUID
    var wordEng: String
    var meanKor: String
    var exampleEng: String
    var exampleKor: String
    var isDone: Bool
    var option1: String
    var option2: String

    
    init(id: UUID = UUID(),
         wordEng: String,
         meanKor: String,
         exampleEng: String,
         exampleKor: String,
         isDone: Bool,
         option1: String,
         option2: String) {
        self.id = id
        self.wordEng = wordEng
        self.meanKor = meanKor
        self.exampleEng = exampleEng
        self.exampleKor = exampleKor
        self.isDone = isDone
        self.option1 = option1
        self.option2 = option2
    }
}

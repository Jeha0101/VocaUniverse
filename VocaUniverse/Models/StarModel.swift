//
//  StarModel.swift
//  VocaUniverse
//
//  Created by Jini on 8/23/25.
//

import Foundation
import SwiftData

//행성 데이터 모델
@Model
final class StarModel {
    @Attribute(.unique) var id: UUID
    var title: String
    
    @Relationship(deleteRule: .cascade) var words: [WordModel] = []
    var progress: Double = 0

    
    init(id: UUID = UUID(), title: String, words: [WordModel], progress: Double) {
        self.id = id
        self.title = title
        self.words = words
        self.progress = progress
    }
}

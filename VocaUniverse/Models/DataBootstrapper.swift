//
//  DataBootstrapper.swift
//  VocaUniverse
//
//  Created by Jini on 8/23/25.
//

import Foundation
import SwiftUI
import SwiftData
import os.log

struct DataBootstrapper {
    
    private let context: ModelContext
    
    private let fileNames = [
        "GRE prep", // 0
        "HighSchool Voca", // 1
        "Instant Vocabulary", // 2
        "Merriam Webster", // 3
        "Reading and Vocabulary", // 4
        "TOEFL", // 5
        "Vocabulary 22000", // 6
        "Vocabulary 22000 Ⅱ", // 7
        "Word Power" // 8
    ]
    
    private let fileExt = "json"
    
    private let logger = Logger.init(subsystem: Bundle.main.bundleIdentifier ?? "name.jehaHwang.VocaUniverse", category: "DataBootstrapper")
    
    public init(context: ModelContext) {
        self.context = context
    }
    
    func bootstrap() throws {
        
        logger.info("started to bootstrap data")
        
        for fileName in fileNames {
            loadAndInsertData(fileName: fileName)
        }
        
        do {
            try context.save()
            logger.info("All vocabulary data saved successfully.")
        } catch {
            logger.error("Failed to save context: \(error.localizedDescription)")
            throw error
        }
    }
    
    private func loadAndInsertData(fileName: String) {
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: fileExt) else {
            logger.error("File not found: \(fileName).json")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let wordList: [WordJSON] = try JSONDecoder().decode([WordJSON].self, from: data)
            //return try JSONDecoder().decode(type, from: data)
            
            //WordModel 배열 생성
            let wordModels: [WordModel] = wordList.map { word in
                WordModel(
                    wordEng: word.wordEng,
                    meanKor: word.meanKor,
                    exampleEng: word.exampleEng,
                    exampleKor: word.exampleKor,
                    isDone: false,
                    option1: word.option1,
                    option2: word.option2,
                    star: word.star
                )
            }
            
            let star = StarModel(
                title: fileName,
                words: wordModels,
                progress: 0
            )
            
            //SwiftData에 저장
            context.insert(star)
            logger.info("Inserted StarModel: \(fileName) with \(wordModels.count) words.")
            
            try context.save()
            
        } catch {
            print("\(fileName) 데이터 로드 실패: \(error)")
        }
    }
    
    struct WordJSON: Codable {
        let wordEng: String
        let meanKor: String
        let exampleEng: String
        let exampleKor: String
        let option1: String
        let option2: String
        let star: String
    }
    
    
    
}

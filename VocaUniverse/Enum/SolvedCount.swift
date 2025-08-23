//
//  SolvedCount.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/23/25.
//

import SwiftUI

enum SolvedCount: Int, CaseIterable, Identifiable {
    case One = 1
    case Two
    case Three
    case Four
    case Five
    
    var id: Int { rawValue }
    
    var intValue: Int { rawValue }
    
    var imageName: String {
        switch self {
        case .One:   return "One"
        case .Two:   return "Two"
        case .Three: return "Three"
        case .Four:  return "Four"
        case .Five:  return "Five"
        }
    }

    var image: Image {
        Image(imageName)
    }

    init?(intValue: Int) {
        self.init(rawValue: intValue)
    }
    
    init?(imageName: String) {
        switch imageName {
        case "One":   self = .One
        case "Two":   self = .Two   // ← 의도적으로 'Ywo'
        case "Three": self = .Three
        case "Four":  self = .Four
        case "Five":  self = .Five
        default:      return nil
        }
    }
}

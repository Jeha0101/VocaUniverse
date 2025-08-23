//
//  Font.swift
//  VocaUniverse
//
//  Created by Jini on 8/23/25.
//

import Foundation
import SwiftUI

extension Font {
    enum VocaUni {
        case black
        case bold
        case semibold
        case light
        case custom(String)
        
        var value: String {
            switch self {
            case .black:
                return "SFPro-Black"
            case .bold:
                return "SFPro-Bold"
            case .semibold:
                return "SFPro-Semibold"
            case .light:
                return "SFPro-Light"
            case .custom(let name):
                return name
            }
        }
    }

    static func vu(_ type: VocaUni, size: CGFloat = 14) -> Font {
        return .custom(type.value, size: size)
    }
    
}

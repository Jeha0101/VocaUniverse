//
//  ArrayChunked.swift
//  VocaUniverse
//
//  Created by 제하맥 on 8/24/25.
//

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] }
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

//
//  CardComponentInfo.swift
//  Resizing Problem
//
//  Created by Kevin on 3/14/23.
//

import Foundation

class CardComponentInfo: Identifiable, ObservableObject {

    let id: UUID
    let type: CardComponentViewType
    @Published var origin: CGPoint
    @Published var size: CGSize
    
    init(id: UUID = UUID(), type: CardComponentViewType, origin: CGPoint, size: CGSize) {
        self.id = id
        self.type = type
        self.origin = origin
        self.size = size
    }
}

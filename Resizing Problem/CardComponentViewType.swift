//
//  CardComponentViewType.swift
//  Resizing Problem
//
//  Created by Kevin on 3/14/23.
//

import Foundation
import SwiftUI

enum CardComponentViewType: CaseIterable, Identifiable {
    
    case text, audio, image
    
    var id: CardComponentViewType { self }
    
    var systemImageName: String {
        switch self {
        case .text: return "text.word.spacing" // "abc"
        case .audio: return "play"
        case .image: return "photo.on.rectangle.angled"
        }
    }
    
    var title: String {
        switch self {
        case .text: return "Text"
        case .audio: return "Audio"
        case .image: return "Images"
        }
    }
    
    var defaultSize: CGSize {
        switch self {
        case .text: return CGSize(width: 200.0, height: 50.0)
        case .audio: return CGSize(width: 50.0, height: 50.0)
        case .image: return CGSize(width: 300.0, height: 300.0)
        }
    }
    
    var color: Color {
        switch self {
        case .text: return .green
        case .audio: return .blue
        case .image: return .red
        }
    }
}

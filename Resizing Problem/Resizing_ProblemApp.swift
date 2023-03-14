//
//  Resizing_ProblemApp.swift
//  Resizing Problem
//
//  Created by Kevin on 3/14/23.
//

import SwiftUI

@main
struct Resizing_ProblemApp: App {

    @StateObject private var model = ViewModel()

    let info = CardComponentInfo(type: .text, origin: .init(x: 300, y: 300), size: .init(width: 200, height: 200))

    var body: some Scene {
        WindowGroup("Ensemble") {
            ZStack {
                Color.white
                ComponentView(info: info, model: model)
            }
            .frame(width: 1000, height: 1000)
        }
    }
}









//
//  ComponentView.swift
//  Resizing Problem
//
//  Created by Kevin on 3/14/23.
//

import Foundation
import SwiftUI

struct ComponentView: View {

    var info: CardComponentInfo
    @ObservedObject var model: ViewModel

    var body: some View {
        ZStack {
            Label(info.type.title, systemImage: info.type.systemImageName)
            ResizingControlsView { point, deltaX, deltaY in
                model.resizedComponentInfo = info
                model.updateForResize(using: point, deltaX: deltaX, deltaY: deltaY)
                //model.updateForResize(point: point, deltaX: deltaX, deltaY: deltaY) // other udpateForResize may work
            } dragEnded: {
                model.resizeEnded()
            }
        }
        .frame(
            width: model.widthForCardComponent(info: info),
            height: model.heightForCardComponent(info: info)
        )
        .background(info.type.color)
        .position(
            x: model.xPositionForCardComponent(info: info),
            y: model.yPositionForCardComponent(info: info)
        )
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    model.draggedComponentInfo = info
                    model.updateForDrag(deltaX: gesture.translation.width, deltaY: gesture.translation.height)
                }
                .onEnded { _ in
                    model.dragEnded()
                }
        )
    }
}

//
//  ResizingConrolsView.swift
//  Resizing Problem
//
//  Created by Kevin on 3/14/23.
//

import Foundation
import SwiftUI

struct ResizingControlsView: View {
    
    let borderColor: Color = .white
    let fillColor: Color = .blue
    let diameter: CGFloat = 15.0
    let dragged: (ResizePoint, CGFloat, CGFloat) -> Void
    let dragEnded: () -> Void
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                grabView(resizePoint: .topLeft)
                Spacer()
                grabView(resizePoint: .topMiddle)
                Spacer()
                grabView(resizePoint: .topRight)
            }
            Spacer()
            HStack(spacing: 0.0) {
                grabView(resizePoint: .leftMiddle)
                Spacer()
                grabView(resizePoint: .rightMiddle)
            }
            Spacer()
            HStack(spacing: 0.0) {
                grabView(resizePoint: .bottomLeft)
                Spacer()
                grabView(resizePoint: .bottomMiddle)
                Spacer()
                grabView(resizePoint: .bottomRight)
            }
        }
    }

    private func grabView(resizePoint: ResizePoint) -> some View {
        var offsetX: CGFloat = 0.0
        var offsetY: CGFloat = 0.0
        let halfDiameter = diameter / 2.0
        switch resizePoint {
        case .topLeft:
            offsetX = -halfDiameter
            offsetY = -halfDiameter
        case .topMiddle:
            offsetY = -halfDiameter
        case .topRight:
            offsetX = halfDiameter
            offsetY = -halfDiameter
        case .rightMiddle:
            offsetX = halfDiameter
        case .bottomRight:
            offsetX = +halfDiameter
            offsetY = halfDiameter
        case .bottomMiddle:
            offsetY = halfDiameter
        case .bottomLeft:
            offsetX = -halfDiameter
            offsetY = halfDiameter
        case .leftMiddle:
            offsetX = -halfDiameter
        }
        return Circle()
            .strokeBorder(borderColor, lineWidth: 3)
            .background(Circle().foregroundColor(fillColor))
            .frame(width: diameter, height: diameter)
            .offset(x: offsetX, y: offsetY)
            .gesture(dragGesture(point: resizePoint))
    }

    private func dragGesture(point: ResizePoint) -> some Gesture {
        DragGesture()
            .onChanged { drag in
                switch point {
                case .topLeft:
                    dragged(point, drag.translation.width, drag.translation.height)
                case .topMiddle:
                    dragged(point, 0, drag.translation.height)
                case .topRight:
                    dragged(point, drag.translation.width, drag.translation.height)
                case .rightMiddle:
                    dragged(point, drag.translation.width, 0)
                case .bottomRight:
                    dragged(point, drag.translation.width, drag.translation.height)
                case .bottomMiddle:
                    dragged(point, 0, drag.translation.height)
                case .bottomLeft:
                    dragged(point, drag.translation.width, drag.translation.height)
                case .leftMiddle:
                    dragged(point, drag.translation.width, 0)
                }
            }
            .onEnded { _ in dragEnded() }
    }
}

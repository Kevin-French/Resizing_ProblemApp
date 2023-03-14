//
//  ViewModel.swift
//  Resizing Problem
//
//  Created by Kevin on 3/14/23.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var componentInfos: [CardComponentInfo] = []
    
    @Published var draggedComponentInfo: CardComponentInfo? = nil
    @Published var dragOffset: CGSize? = nil
    
    @Published var selectedComponentInfo: CardComponentInfo? = nil
    
    @Published var selectedTypeToAdd: CardComponentViewType? = nil
    @Published var componentBeingAddedInfo: CardComponentInfo? = nil
    
    @Published var resizedComponentInfo: CardComponentInfo? = nil
    @Published var resizeOffset: CGSize? = nil
    @Published var resizePoint: ResizePoint? = nil
    
    func widthForCardComponent(info: CardComponentInfo) -> CGFloat {
        let widthOffset = (resizedComponentInfo?.id == info.id) ? (resizeOffset?.width ?? 0.0) : 0.0
        return info.size.width + widthOffset
    }
    
    func heightForCardComponent(info: CardComponentInfo) -> CGFloat {
        let heightOffset = (resizedComponentInfo?.id == info.id) ? (resizeOffset?.height ?? 0.0) : 0.0
        return info.size.height + heightOffset
    }
    
    func xPositionForCardComponent(info: CardComponentInfo) -> CGFloat {
        let xPositionOffset = (draggedComponentInfo?.id == info.id) ? (dragOffset?.width ?? 0.0) : 0.0
        return info.origin.x + (info.size.width / 2.0) + xPositionOffset
    }
    
    func yPositionForCardComponent(info: CardComponentInfo) -> CGFloat {
        let yPositionOffset = (draggedComponentInfo?.id == info.id) ? (dragOffset?.height ?? 0.0) : 0.0
        return info.origin.y + (info.size.height / 2.0) + yPositionOffset
    }
    
    func updateForResize(point: ResizePoint, deltaX: CGFloat, deltaY: CGFloat) {
        resizeOffset = CGSize(width: deltaX, height: deltaY)
        resizePoint = resizePoint
    }
    
    func resizeEnded() {
        guard let resizedComponentInfo, let resizePoint, let resizeOffset else { return }
        var w: CGFloat = resizedComponentInfo.size.width
        var h: CGFloat = resizedComponentInfo.size.height
        var x: CGFloat = resizedComponentInfo.origin.x
        var y: CGFloat = resizedComponentInfo.origin.y
        switch resizePoint {
        case .topLeft:
            w -= resizeOffset.width
            h -= resizeOffset.height
            x += resizeOffset.width
            y += resizeOffset.height
        case .topMiddle:
            h -= resizeOffset.height
            y += resizeOffset.height
        case .topRight:
            w += resizeOffset.width
            h -= resizeOffset.height
        case .rightMiddle:
            w += resizeOffset.width
        case .bottomRight:
            w += resizeOffset.width
            h += resizeOffset.height
        case .bottomMiddle:
            h += resizeOffset.height
        case .bottomLeft:
            w -= resizeOffset.width
            h += resizeOffset.height
            x -= resizeOffset.width
            y += resizeOffset.height
        case .leftMiddle:
            w -= resizeOffset.width
            x += resizeOffset.width
        }
        resizedComponentInfo.size = CGSize(width: w, height: h)
        resizedComponentInfo.origin = CGPoint(x: x, y: y)
        self.resizeOffset = nil
        self.resizePoint = nil
        self.resizedComponentInfo = nil
    }
    
    func updateForDrag(deltaX: CGFloat, deltaY: CGFloat) {
        dragOffset = CGSize(width: deltaX, height: deltaY)
    }
    
    func dragEnded() {
        guard let dragOffset else { return }
        draggedComponentInfo?.origin.x += dragOffset.width
        draggedComponentInfo?.origin.y += dragOffset.height
        draggedComponentInfo = nil
        self.dragOffset = nil
    }
    
    func updateForResize(using resizePoint: ResizePoint, deltaX: CGFloat, deltaY: CGFloat) {
        
        guard let resizedComponentInfo else { return }
        
        var width: CGFloat = resizedComponentInfo.size.width
        var height: CGFloat = resizedComponentInfo.size.height
        var x: CGFloat = resizedComponentInfo.origin.x
        var y: CGFloat = resizedComponentInfo.origin.y
        switch resizePoint {
        case .topLeft:
            width -= deltaX
            height -= deltaY
            x += deltaX
            y += deltaY
        case .topMiddle:
            height -= deltaY
            y += deltaY
        case .topRight:
            width += deltaX
            height -= deltaY
            y += deltaY
            print(width, height, x)
        case .rightMiddle:
            width += deltaX
        case .bottomRight:
            width += deltaX
            height += deltaY
        case .bottomMiddle:
            height += deltaY
        case .bottomLeft: //
            width -= deltaX
            height += deltaY
            x += deltaX
        case .leftMiddle:
            width -= deltaX
            x += deltaX
        }
        resizedComponentInfo.size = CGSize(width: width, height: height)
        resizedComponentInfo.origin = CGPoint(x: x, y: y)
    }
}

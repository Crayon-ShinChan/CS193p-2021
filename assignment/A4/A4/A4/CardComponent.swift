//
//  CardComponent.swift
//  A3
//
//  Created by Leon Z on 2023-03-27.
//

import SwiftUI

struct CardComponent: Shape, View {
    let shape: CardShape
    
    
    func path(in rect: CGRect) -> Path {
        switch shape {
        case .diamond: return drawDiamond(in: rect)
        case .oval: return drawOval(in: rect)
        case .squiggle: return drawSquiggle(in: rect)
        }
    }
    
    private func drawDiamond(in rect: CGRect) -> Path {
        let topPoint = CGPoint(x: rect.midX, y: rect.minY)
        let bottomPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let leftPoint = CGPoint(x: rect.minX, y: rect.midY)
        let rightPoint = CGPoint(x: rect.maxX, y: rect.midY)
        
        var p = Path()
        p.move(to: topPoint)
        p.addLine(to: leftPoint)
        p.addLine(to: bottomPoint)
        p.addLine(to: rightPoint)
        p.addLine(to: topPoint)
        
        return p
    }
    
    private func drawOval(in rect: CGRect) -> Path {
        // init((inout Path) -> ()) & closure
        Path { path in
            let radius = rect.height / 2
            path.addRoundedRect(
                in: CGRect(x: 0, y: 0, width: rect.width, height: rect.height),
                cornerSize: CGSize(width: radius, height: radius)
            )
        }
    }
    
    private func drawSquiggle(in rect: CGRect) -> Path {
        // https://stackoverflow.com/questions/25387940/how-to-draw-a-perfect-squiggle-in-set-card-game-with-objective-c
        var path = Path()
                
        path.move(to: CGPoint(x: 104.0, y: 15.0))
        path.addCurve(to: CGPoint(x: 63.0, y: 54.0),
                      control1: CGPoint(x: 112.4, y: 36.9),
                      control2: CGPoint(x: 89.7, y: 60.8))
        path.addCurve(to: CGPoint(x: 27.0, y: 53.0),
                      control1: CGPoint(x: 52.3, y: 51.3),
                      control2: CGPoint(x: 42.2, y: 42.0))
        path.addCurve(to: CGPoint(x: 5.0, y: 40.0),
                      control1: CGPoint(x: 9.6, y: 65.6),
                      control2: CGPoint(x: 5.4, y: 58.3))
        path.addCurve(to: CGPoint(x: 36.0, y: 12.0),
                      control1: CGPoint(x: 4.6, y: 22.0),
                      control2: CGPoint(x: 19.1, y: 9.7))
        path.addCurve(to: CGPoint(x: 89.0, y: 14.0),
                      control1: CGPoint(x: 59.2, y: 15.2),
                      control2: CGPoint(x: 61.9, y: 31.5))
        path.addCurve(to: CGPoint(x: 104.0, y: 15.0),
                      control1: CGPoint(x: 95.3, y: 10.0),
                      control2: CGPoint(x: 100.9, y: 6.9))
        
        let pathRect = path.boundingRect
        path = path.offsetBy(dx: rect.minX - pathRect.minX, dy: rect.minY - pathRect.minY)
        
        let scale: CGFloat = rect.width / pathRect.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        path = path.applying(transform)
        
        
        return path
            .offsetBy(dx: rect.minX - path.boundingRect.minX, dy: rect.midY - path.boundingRect.midY)
    }
}


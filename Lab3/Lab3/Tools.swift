import Foundation
import SwiftUI
import Combine

class ObservableArray<T>: ObservableObject {
    @Published var array:[T] = []
    var cancellables = [AnyCancellable]()

    init(array: [T]) {
        self.array = array
    }

    func observeChildrenChanges<T: ObservableObject>() -> ObservableArray<T> {
        let array2 = array as! [T]
        array2.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })

            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables.append(c)
        })
        return self as! ObservableArray<T>
    }
}

class ToolClass: ObservableObject {
    var color: Color
    var lineWidth: CGFloat
    
    init(color: Color, lineWidth: CGFloat) {
        self.color = color
        self.lineWidth = lineWidth
    }
}

class LineClass: ToolClass {
    var points: [CGPoint]
    
    init(points: [CGPoint], color: Color, lineWidth: CGFloat) {
        self.points = points
        super.init(color: color, lineWidth: lineWidth)
    }
}

class StraightClass: ToolClass {
    var points: [CGPoint]
    
    init(points: [CGPoint], color: Color, lineWidth: CGFloat) {
        self.points = points
        super.init(color: color, lineWidth: lineWidth)
    }
}

class EllipseClass: ToolClass {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    
    init(origin: CGPoint, width: CGFloat, height: CGFloat, color: Color, lineWidth: CGFloat) {
        self.origin = origin
        self.width = width
        self.height = height
        super.init(color: color, lineWidth: lineWidth)
    }
}

class RectangleClass: ToolClass {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    
    init(origin: CGPoint, width: CGFloat, height: CGFloat, color: Color, lineWidth: CGFloat) {
        self.origin = origin
        self.width = width
        self.height = height
        super.init(color: color, lineWidth: lineWidth)
    }
}

struct LineStruct {
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
}

struct StraightStruct {
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
}

struct EllipseStruct {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    var color: Color
    var lineWidth: CGFloat
}

struct RectangleStruct {
    var origin: CGPoint
    var width: CGFloat
    var height: CGFloat
    var color: Color
    var lineWidth: CGFloat
}

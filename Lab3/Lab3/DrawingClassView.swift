import Foundation
import SwiftUI
import Combine

struct DrawingClassView: View {
    @ObservedObject var lines: ObservableArray<LineClass> = ObservableArray<LineClass>(array: [])
            .observeChildrenChanges()
    @ObservedObject var straights: ObservableArray<StraightClass> = ObservableArray<StraightClass>(array: [])
            .observeChildrenChanges()
    @ObservedObject var ellipses: ObservableArray<EllipseClass> = ObservableArray<EllipseClass>(array: [])
            .observeChildrenChanges()
    @ObservedObject var rectangles: ObservableArray<RectangleClass> = ObservableArray<RectangleClass>(array: [])
            .observeChildrenChanges()

    @State private var selectedTool: String = "Line"
    @State private var selectedColor: Color = .red
    @State private var selectedWidth: CGFloat = 5

    var body: some View {
        VStack {
            VStack {
                Picker(selection: $selectedTool, label: Text("Выберите инструмент")) {
                    Text("Кривая").tag("Line")
                    Text("Прямая").tag("Straight")
                    Text("Эллипс").tag("Ellipse")
                    Text("Квадрат").tag("Rectangle")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(minHeight: 40)

                HStack {
                    Text("Выберите цвет")
                    Spacer()
                    ColorPicker("Выберите цвет", selection: $selectedColor)
                        .labelsHidden()
                }
                .frame(minHeight: 40)

                HStack {
                    Text("Выберите толщину")
                    Spacer()
                    Slider(value: $selectedWidth, in: 1...10) {
                    }
                    .frame(maxWidth: 190)
                }
                .frame(minHeight: 40)

                HStack {
                    Button("Очистить", action: {
                        lines.array = []
                        straights.array = []
                        ellipses.array = []
                        rectangles.array = []
                    })
                        .foregroundColor(.red)
                    Spacer()
                }
                .frame(minHeight: 40)
            }
            .padding()

            Divider()

            Canvas { context, size in
                for line in lines.array {
                    var path = Path()
                    path.addLines(line.points)

                    context.stroke(path,
                                   with: .color(line.color),
                                   lineWidth: line.lineWidth)
                }

                for straight in straights.array {
                    var path = Path()
                    path.addLines(straight.points)

                    context.stroke(path,
                                   with: .color(straight.color),
                                   lineWidth: straight.lineWidth)
                }

                for ellipse in ellipses.array {
                    let width = ellipse.width
                    let height = ellipse.height

                    var path = Path()
                    path.addEllipse(in: CGRect(origin: ellipse.origin,
                                               size: CGSize(width: width,
                                                            height: height)))

                    context.stroke(
                        path,
                        with: .color(ellipse.color),
                        lineWidth: ellipse.lineWidth)
                }

                for rectangle in rectangles.array {
                    let width = rectangle.width
                    let height = rectangle.height

                    var path = Path()
                    path.addRect(CGRect(origin: rectangle.origin,
                                        size: CGSize(width: width,
                                                     height: height)))

                    context.stroke(
                        path,
                        with: .color(rectangle.color),
                        lineWidth: rectangle.lineWidth)
                }
            }
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ value in
                switch selectedTool {
                case "Straight":
                    let lastPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        let firstPoint = value.location
                        straights.array.append(StraightClass(points: [firstPoint],
                                                  color: selectedColor,
                                                  lineWidth: selectedWidth))
                    } else {
                        let index = straights.array.count - 1

                        if straights.array[index].points.count == 2 {
                            straights.array[index].points[1] = lastPoint
                        } else {
                            straights.array[index].points.append(lastPoint)
                        }
                    }

                case "Ellipse":
                    if value.translation.width + value.translation.height == 0 {
                    let firstPoint = value.startLocation
                        ellipses.array.append(EllipseClass(origin: firstPoint,
                                                width: 0,
                                                height: 0,
                                                color: selectedColor,
                                                lineWidth: selectedWidth))
                    } else {
                        let index = ellipses.array.count - 1
                        ellipses.array[index].width = value.translation.width
                        ellipses.array[index].height = value.translation.height
                    }

                case "Rectangle":
                    if value.translation.width + value.translation.height == 0 {
                    let firstPoint = value.startLocation
                        rectangles.array.append(RectangleClass(origin: firstPoint,
                                                width: 0,
                                                height: 0,
                                                color: selectedColor,
                                                lineWidth: selectedWidth))
                    } else {
                        let index = rectangles.array.count - 1
                        rectangles.array[index].width = value.translation.width
                        rectangles.array[index].height = value.translation.height
                    }

                default:
                    let newPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        lines.array.append(LineClass(points: [newPoint],
                                          color: selectedColor,
                                          lineWidth: selectedWidth))
                    } else {
                        let index = lines.array.count - 1
                        lines.array[index].points.append(newPoint)
                    }
                }
            }))
            Divider()
        }
    }
}

struct DrawingClassView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingClassView()
    }
}

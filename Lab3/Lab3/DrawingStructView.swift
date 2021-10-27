import SwiftUI

struct DrawingStructView: View {
    @State private var lines = [LineStruct]()
    @State private var straights = [StraightStruct]()
    @State private var ellipses = [EllipseStruct]()
    @State private var rectangles = [RectangleStruct]()
    
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
                        lines = [LineStruct]()
                        straights = [StraightStruct]()
                        ellipses = [EllipseStruct]()
                        rectangles = [RectangleStruct]()
                    })
                        .foregroundColor(.red)
                    Spacer()
                }
                .frame(minHeight: 40)
            }
            .padding()
            
            Divider()
            
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    
                    context.stroke(path,
                                   with: .color(line.color),
                                   lineWidth: line.lineWidth)
                }
                
                for straight in straights {
                    var path = Path()
                    path.addLines(straight.points)
                    
                    context.stroke(path,
                                   with: .color(straight.color),
                                   lineWidth: straight.lineWidth)
                }
                
                for ellipse in ellipses {
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
                
                for rectangle in rectangles {
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
                        straights.append(StraightStruct(points: [firstPoint],
                                                  color: selectedColor,
                                                  lineWidth: selectedWidth))
                    } else {
                        let index = straights.count - 1

                        if straights[index].points.count == 2 {
                            straights[index].points[1] = lastPoint
                        } else {
                            straights[index].points.append(lastPoint)
                        }
                    }

                case "Ellipse":
                    if value.translation.width + value.translation.height == 0 {
                    let firstPoint = value.startLocation
                        ellipses.append(EllipseStruct(origin: firstPoint,
                                                width: 0,
                                                height: 0,
                                                color: selectedColor,
                                                lineWidth: selectedWidth))
                    } else {
                        let index = ellipses.count - 1
                        ellipses[index].width = value.translation.width
                        ellipses[index].height = value.translation.height
                    }
                    
                case "Rectangle":
                    if value.translation.width + value.translation.height == 0 {
                    let firstPoint = value.startLocation
                        rectangles.append(RectangleStruct(origin: firstPoint,
                                                width: 0,
                                                height: 0,
                                                color: selectedColor,
                                                lineWidth: selectedWidth))
                    } else {
                        let index = rectangles.count - 1
                        rectangles[index].width = value.translation.width
                        rectangles[index].height = value.translation.height
                    }
                    
                default:
                    let newPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        lines.append(LineStruct(points: [newPoint],
                                          color: selectedColor,
                                          lineWidth: selectedWidth))
                    } else {
                        let index = lines.count - 1
                        lines[index].points.append(newPoint)
                    }
                }
            }))
            Divider()

        }
    }
}

struct DrawingStructView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingStructView()
    }
}

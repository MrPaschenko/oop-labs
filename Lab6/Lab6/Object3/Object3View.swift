import SwiftUI
import SwiftUICharts

extension Collection where Iterator.Element == String {
    var convertToDouble: [Double] {
        return compactMap{ Double($0) }
    }
    var convertToFloat: [Float] {
        return compactMap{ Float($0) }
    }
}

struct Object3View: View {
    @State var array: [Double] = []

    var body: some View {
        VStack {
            LineView(data: array, title: "График")
                .padding()
                .onAppear {
                    array = UIPasteboard.general.string!.components(separatedBy: ", ").convertToDouble
                }
            
//            Button {
//                array = UIPasteboard.general.string!.components(separatedBy: ", ").convertToDouble
//            } label: {
//                Text("Вставить массив")
//            }
//            .padding()
        }
    }
}

struct Object3View_Previews: PreviewProvider {
    static var previews: some View {
        Object3View()
    }
}

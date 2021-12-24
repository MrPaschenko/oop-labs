import SwiftUI

struct Object2View: View {
    @EnvironmentObject var numbers: Numbers
    @State var isArray = false
    @State var numbersArray: [Double] = []
    @State private var copiedAlert = false
    
    var body: some View {
        VStack {
            List {
                ForEach(numbersArray, id: \.self) { item in
                    HStack {
                        Text("\(numbersArray.firstIndex(of: item)!)")
                        Spacer()
                        Text("\(item)")
                    }
                }
            }
            .onAppear {
                if !isArray {
                    for _ in 0 ... (Int(numbers.n)! - 1) {
                        numbersArray.append(Double.random(in: Double(numbers.Min)! ... Double(numbers.Max)!))
                    }
                    isArray = true
                }
                
                var arrayOfStrings: [String] = []
                for item in numbersArray {
                    arrayOfStrings.append(String(item))
                }
                
                let string = arrayOfStrings.joined(separator: ", ")
                
                UIPasteboard.general.string = string
                
//                copiedAlert = true

            }
//            .onTapGesture {
//                var arrayOfStrings: [String] = []
//                for item in numbersArray {
//                    arrayOfStrings.append(String(item))
//                }
//
//                let string = arrayOfStrings.joined(separator: ", ")
//
//                UIPasteboard.general.string = string
//
//                copiedAlert = true
//            }
//            .alert("Массив скопирован в буфер обмена", isPresented: $copiedAlert) {
//                Button("OK", role: .cancel) {  }
//            }
            
            Button {
                numbersArray = []
                for _ in 0 ... (Int(numbers.n)! - 1) {
                    numbersArray.append(Double.random(in: Double(numbers.Min)! ... Double(numbers.Max)!))
                }
                isArray = true
            } label: {
                Text("Сгенерировать массив")
            }
            .padding()
        }
    }
}

struct Object2View_Previews: PreviewProvider {
    static var myEnvObject = Numbers(n: "", Min: "", Max: "")
    
    static var previews: some View {
        Object2View()
            .environmentObject(myEnvObject)
    }
}

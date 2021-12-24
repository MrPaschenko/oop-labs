import SwiftUI
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Lab6View: View {
    @EnvironmentObject var numbers: Numbers
    @State private var showingAlert = false
    @State private var continueAlert = false

    var body: some View {
        VStack {
            TextField("n", text: $numbers.n)
                .padding()
                .frame(width: 200)
                .background(.bar)
                .cornerRadius(15)
                .keyboardType(.decimalPad)
            
            TextField("Min", text: $numbers.Min)
                .padding()
                .frame(width: 200)
                .background(.bar)
                .cornerRadius(15)
                .keyboardType(.decimalPad)
            
            TextField("Max", text: $numbers.Max)
                .padding()
                .frame(width: 200)
                .background(.bar)
                .cornerRadius(15)
                .keyboardType(.decimalPad)
            
            Button("Старт") {
                hideKeyboard()
                
                if numbers.n.isEmpty || numbers.Min.isEmpty || numbers.Max.isEmpty {
                    showingAlert = true
                } else {
                    continueAlert = true
                }
            }
            .alert("Что-то не заполнено", isPresented: $showingAlert) {
                Button("OK", role: .cancel) {  }
            }
            .alert("Успех! Переключитесь на Object2", isPresented: $continueAlert) {
                Button("OK", role: .cancel) {  }
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
        }
    }
}

struct Lab6View_Previews: PreviewProvider {
    static var myEnvObject = Numbers(n: "", Min: "", Max: "")
    
    static var previews: some View {
        Lab6View()
            .environmentObject(myEnvObject)
    }
}

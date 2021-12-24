import SwiftUI

struct ContentView: View {
    var numbers = Numbers(n: "", Min: "", Max: "")
    
    var body: some View {
        TabView {
            Lab6View()
                .tabItem {
                    Text("Lab6")
                    Image(systemName: "1.square")
                }
            
            Object2View()
                .tabItem {
                    Text("Object2")
                    Image(systemName: "2.square")
                }
            
            Object3View()
                .tabItem {
                    Text("Object3")
                    Image(systemName: "3.square")
                }
        }
        .environmentObject(numbers)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var myEnvObject = Numbers(n: "", Min: "", Max: "")
    
    static var previews: some View {
        ContentView()
            .environmentObject(myEnvObject)
    }
}

import Foundation

class Numbers: ObservableObject {
    @Published var n: String
    @Published var Min: String
    @Published var Max: String
    
    init(n: String, Min: String, Max: String) {
        self.n = n
        self.Min = Min
        self.Max = Max
    }
}

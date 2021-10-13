import SwiftUI

struct ExampleView: View {
    var body: some View {
        Canvas { context, size in
            context.stroke(
                Path(CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: 300, height: 100))),
                with: .color(.red),
                lineWidth: 4)
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}

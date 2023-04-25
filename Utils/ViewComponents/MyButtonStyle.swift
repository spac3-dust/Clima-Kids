import SwiftUI

struct MyButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title2, design: .rounded))
            .foregroundColor(.white)
            .padding()
            .background(Color.pistachio)
            .cornerRadius(25)
            .shadow(radius: 0.5, x: 5, y: 5)
    }
}

extension View {
    func myButtonStyle() -> some View {
        modifier(MyButtonStyle())
    }
}

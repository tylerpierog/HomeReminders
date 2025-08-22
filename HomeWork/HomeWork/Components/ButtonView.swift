import SwiftUI

struct ButtonView: View {
    let buttonText: String
    let buttonColour: Color
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(buttonText)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(buttonColour)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

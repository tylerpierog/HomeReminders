import SwiftUI

struct LoginTextFieldView: View {
    @Binding var textValue: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $textValue)
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

import SwiftUI

struct LoginTextFieldView: View {
    @Binding var textValue: String
    let placeholder: String
    var isSecure: Bool = false
    
    var body: some View {
        textField
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
            .accessibilityHint("Text Field")
    }
    
    @ViewBuilder
    private var textField: some View {
        if isSecure {
            secureTextField
        } else {
            normalTextField
        }
    }
    
    private var secureTextField: some View {
        SecureField(placeholder, text: $textValue)
    }
    
    private var normalTextField: some View {
        TextField(placeholder, text: $textValue)
    }
}

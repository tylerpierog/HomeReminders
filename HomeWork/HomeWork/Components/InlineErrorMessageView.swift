import SwiftUI

struct InlineErrorMessageView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.red)
            .font(.footnote)
            .fontWeight(.regular)
            .padding(.leading, 5)
    }
}


import SwiftUI

struct ButtonWithLeftIconAndTextView: View {
    let imageName: String
    let text: Binding<String>
    let action: ButtonAction
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: imageName)
                    .font(.title)
                    .foregroundColor(Color.buttonColour)
                Text(text.wrappedValue)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(.black)
                Spacer()
            }
        }
    }
}

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(1.2)
            .frame(width: 80, height: 80)
            .background(Color.secondaryButtonColour.opacity(0.7))
            .cornerRadius(15)
    }
}

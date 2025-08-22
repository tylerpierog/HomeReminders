import SwiftUI

struct HomeWorkBrandingHeaderView: View {
    var compact: Bool = false

    var body: some View {
        HStack(spacing: compact ? 8 : 12) {
            HStack(spacing: compact ? 2 : 4) {
                Text("Home")
                    .font(.system(size: compact ? 34 : 48, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.buttonColour)
                Text("Work")
                    .font(.system(size: compact ? 34 : 48, weight: .regular, design: .rounded))
                    .foregroundStyle(Color.secondaryButtonColour)
            }
            .kerning(0.5)
        }
        .accessibilityHidden(true)
    }
}


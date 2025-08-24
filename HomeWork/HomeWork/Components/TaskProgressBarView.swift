import SwiftUI

struct TaskProgressBarView: View {
    var progress: Double = 0.6
    var height: CGFloat = 20
    var fill: Color = Color.secondaryButtonColour
    
    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.white)
                    Capsule()
                        .fill(fill)
                        .frame(width: geo.size.width * max(0, min(progress, 1)))
                        .animation(.easeInOut(duration: 0.35), value: progress)
                }
            }
            .frame(height: height)
            
            Text("\(Int((max(0, min(progress, 1)))*100))%")
                .font(.system(.title3, weight: .bold))
                .foregroundColor(.primary)
                .accessibilityLabel("Progress \(Int(progress * 100)) percent")
        }
    }
}

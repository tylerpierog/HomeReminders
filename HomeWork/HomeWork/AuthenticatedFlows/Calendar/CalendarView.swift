import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 48))
            Text("Upcoming maintenance")
                .foregroundStyle(.black)
        }
        .navigationTitle("Calendar")
        .navigationBarTitleDisplayMode(.inline)
    }
}

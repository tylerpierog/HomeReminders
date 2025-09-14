import SwiftUI

struct ConfirmTaskView: View {
    @EnvironmentObject var taskCoordinator: TaskCoordinator
    
    var body: some View {
        Text("Confirm Task")
            .navigationTitle("Confirm Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.navBarColour.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
        Button("Confirm") {
            taskCoordinator.goToCompletion()
        }
        .navigationTitle("Confirm")
        .navigationBarTitleDisplayMode(.inline)
    }
}

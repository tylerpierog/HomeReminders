import SwiftUI

struct CompletionTaskView: View {
    @EnvironmentObject var taskCoordinator: TaskCoordinator

    var body: some View {
        Text("Completed Task")
            .navigationTitle("Completed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.navBarColour.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
        Button("Go Home") {
            taskCoordinator.popToRoot()
        }
    }
}

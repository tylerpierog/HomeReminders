import SwiftUI

struct TasksView: View {
    @EnvironmentObject var taskCoordinator: TaskCoordinator
    
    var body: some View {
        VStack {
            List {
                Label("Change furnace filter", systemImage: "wind")
                Label("Clean dishwasher filter", systemImage: "sparkles")
                Label("Test smoke alarms", systemImage: "bell.badge")
            }
            
            Button("Press me") {
                taskCoordinator.goToConfirm()
            }
        }
        .navigationTitle("Tasks")
        .navigationBarTitleDisplayMode(.inline)
    }
}

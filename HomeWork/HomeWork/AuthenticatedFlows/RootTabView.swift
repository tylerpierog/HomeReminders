import SwiftUI

// TODO: Move these to their own file and organize it and start to build out the pages
struct RootTabView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var taskCoordinator: TaskCoordinator
    @EnvironmentObject var settingsCoordinator: SettingsCoordinator
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView {
                DashboardView()
                    .tabItem { Label("Home", systemImage: "house.fill") }
                
                TasksView()
                    .tabItem { Label("Tasks", systemImage: "checklist") }
                
                CalendarView()
                    .tabItem { Label("Calendar", systemImage: "calendar") }
                
                SettingsView()
                    .tabItem { Label("Settings", systemImage: "gearshape") }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.navBarColour.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .navigationDestination(for: AnyHashable.self) { key in
                router.destination(for: key)
            }
            .tint(Color(red: 210/255, green: 108/255, blue: 58/255))
        }
    }
}

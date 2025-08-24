import SwiftUI

// TODO: Move these to their own file and organize it and start to build out the pages
struct RootTabView: View {
    
    var body: some View {
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
        .tint(Color(red: 210/255, green: 108/255, blue: 58/255)) // brand accent
    }
}


struct TasksView: View {
    var body: some View {
        NavigationStack {
            List {
                Label("Change furnace filter", systemImage: "wind")
                Label("Clean dishwasher filter", systemImage: "sparkles")
                Label("Test smoke alarms", systemImage: "bell.badge")
            }
            .navigationTitle("Tasks")
        }
    }
}

struct CalendarView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "calendar.badge.clock")
                    .font(.system(size: 48))
                Text("Upcoming maintenance")
                    .foregroundStyle(.black)
            }
            .navigationTitle("Calendar")
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject private var session: AppSession

    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    Button("Sign Out") { session.signOut() }
                }
                Section("Appearance") { Toggle("Use system theme", isOn: .constant(true)) }
            }
            .navigationTitle("Settings")
        }
    }
}

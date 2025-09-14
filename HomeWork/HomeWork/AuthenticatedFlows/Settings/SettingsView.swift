import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var session: AppSession
    @EnvironmentObject var settingsCoordinator: SettingsCoordinator
    
    var body: some View {
        List {
            Section("Account") {
                Button("Sign Out") { session.signOut() }
                Text("View Profile")
                    .onTapGesture {
                        settingsCoordinator.goToProfile()
                    }
            }
            Section("Appearance") { Toggle("Use system theme", isOn: .constant(true)) }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

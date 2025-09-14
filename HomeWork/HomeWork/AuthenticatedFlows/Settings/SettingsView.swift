import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var session: AppSession
    @EnvironmentObject var settingsCoordinator: SettingsCoordinator
    
    var body: some View {
        List {
            Section("Account") {
                Button("Sign Out") { session.signOut() }
                viewProfileItem
            }
            Section("Appearance") { Toggle("Use system theme", isOn: .constant(true)) }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var viewProfileItem: some View {
        HStack {
            Text("View Profile")
                
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            settingsCoordinator.goToProfile()
        }
    }
}

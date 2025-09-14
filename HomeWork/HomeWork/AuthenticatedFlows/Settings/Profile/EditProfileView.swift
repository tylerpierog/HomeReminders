import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var settingsCoordinator: SettingsCoordinator
    
    var body: some View {
        Text("Edit profile")
            .navigationTitle("Edit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.navBarColour.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
        Button("Go Home") {
            settingsCoordinator.popToRoot()
        }
    }
}

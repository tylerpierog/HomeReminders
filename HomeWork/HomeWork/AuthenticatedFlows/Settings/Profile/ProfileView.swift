import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var settingsCoordinator: SettingsCoordinator
    
    var body: some View {
        Text("Profile")
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.navBarColour.opacity(0.85), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
        Button("Edit Profile") {
            settingsCoordinator.goToEditProfile()
        }
    }
}

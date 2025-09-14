import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: AppSession
    @EnvironmentObject var router: Router
    @EnvironmentObject var taskCoordinator: TaskCoordinator
    @EnvironmentObject var settingsCoordinator: SettingsCoordinator
    
    var body: some View {
        switch session.phase {
        case .unauthenticated:
            LoginView()
        case .onboarding, .authenticated:
            RootTabView()
                .environmentObject(router)
                .environmentObject(taskCoordinator)
                .environmentObject(settingsCoordinator)
        }
    }
}

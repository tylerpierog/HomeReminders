import SwiftUI

struct RootView: View {
    @EnvironmentObject var session: AppSession

    var body: some View {
        switch session.phase {
        case .unauthenticated:
            LoginView()
        case .onboarding, .authenticated:
            RootTabView()
        }
    }
}

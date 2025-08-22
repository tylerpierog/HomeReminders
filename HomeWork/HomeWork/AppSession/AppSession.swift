import SwiftUI

@MainActor
final class AppSession: ObservableObject {
    @Published var phase: AppPhase = .unauthenticated

    func didAuthenticate() {
        phase = .authenticated
    }

    func signOut() {
        phase = .unauthenticated
    }
}

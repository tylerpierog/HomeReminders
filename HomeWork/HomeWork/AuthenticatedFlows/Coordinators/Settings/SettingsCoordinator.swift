import SwiftUI

enum SettingsRoute {
    case viewProfile
    case editProfile
}

@MainActor
final class SettingsCoordinator: NavigationCoordinating {
    weak var router: Router?
    
    init(router: Router) {
        self.router = router
        
        router.register(SettingsRoute.viewProfile) {
            ProfileView()
        }
        
        router.register(SettingsRoute.editProfile) {
            EditProfileView()
        }
    }
    
    func goToProfile() {
        router?.push(SettingsRoute.viewProfile)
    }
    
    func goToEditProfile() {
        router?.push(SettingsRoute.editProfile)
    }
}

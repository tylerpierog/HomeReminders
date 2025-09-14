import SwiftUI

enum TaskRoute {
    case confirm
    case completion
}

@MainActor
final class TaskCoordinator: NavigationCoordinating {
    weak var router: Router?
    
    init(router: Router) {
        self.router = router
        
        router.register(TaskRoute.confirm) {
            ConfirmTaskView()
        }
        
        router.register(TaskRoute.completion) {
            CompletionTaskView()
        }
    }
    
    func goToConfirm() {
        router?.push(TaskRoute.confirm)
    }
    
    func goToCompletion() {
        router?.push(TaskRoute.completion)
    }
}

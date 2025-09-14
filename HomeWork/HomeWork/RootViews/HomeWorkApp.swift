import SwiftUI

@main
struct HomeWorkApp: App {
    @StateObject private var session = AppSession()
    @StateObject private var router: Router
    @StateObject private var taskCoordinator: TaskCoordinator
    @StateObject private var settingsCoordinator: SettingsCoordinator
    
    init() {
        let newRouter = Router()
        _router = StateObject(wrappedValue: newRouter)
        _taskCoordinator = StateObject(wrappedValue: TaskCoordinator(router: newRouter))
        _settingsCoordinator = StateObject(wrappedValue: SettingsCoordinator(router: newRouter))
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
                .environmentObject(router)
                .environmentObject(taskCoordinator)
                .environmentObject(settingsCoordinator)
        }
    }
}

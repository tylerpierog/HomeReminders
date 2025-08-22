import SwiftUI

@main
struct HomeWorkApp: App {
    @StateObject private var session = AppSession()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(session)
        }
    }
}

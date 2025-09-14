import SwiftUI

@MainActor
final class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    private var registry: [AnyHashable: () -> AnyView] = [:]
    
    func register<ID: Hashable>(_ id: ID, builder: @escaping () -> some View) {
        registry[AnyHashable(id)] = {
            AnyView(builder())
        }
    }
    
    func push<ID: Hashable>(_ id: ID) {
        path.append(AnyHashable(id))
    }
    
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot() {
        path = .init()
    }
    
    func destination(for key: AnyHashable) -> AnyView {
        registry[key]?() ?? AnyView(EmptyView())
    }
    
    func applyPath(_ items: [AnyHashable]) {
        var new = NavigationPath()
        for i in items { new.append(i) }
        path = new
    }
}

import SwiftUI

@MainActor
protocol NavigationCoordinating: ObservableObject {
    var router: Router? { get }
    func pop()
    func popToRoot()
}

extension NavigationCoordinating {
    func pop() {
        router?.pop()
    }
    
    func popToRoot() {
        router?.popToRoot()
    }
}

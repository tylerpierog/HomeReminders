import SwiftUI
import WeatherKit
import CoreLocation

@MainActor
protocol WeatherProviding {
    func getTodaySnapshot() async throws -> (current: CurrentForecast, dayparts: [DaypartForecast])
}

struct WeatherProvider: WeatherProviding {
    private let locationService = LocationService()
    private let service = WeatherService()
    private let snapshotBuilder = WeatherSnapshotBuilder()

    func getTodaySnapshot() async throws -> (current: CurrentForecast, dayparts: [DaypartForecast]) {
        let location = try await locationService.requestCurrentLocation()
        let hourly = try await service.weather(for: location, including: .hourly)
        
        return try snapshotBuilder.build(hourlyForecast: Array(hourly))
    }
}

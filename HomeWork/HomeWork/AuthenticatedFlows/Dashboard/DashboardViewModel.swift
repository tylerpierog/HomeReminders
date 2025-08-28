import SwiftUI

@MainActor
class DashboardViewModel: ObservableObject {
    let options = ["Morning", "Afternoon", "Evening", "Night"]
    let upcomingTasksHeader = "Upcoming Tasks"
    
    var weatherProvider: WeatherProviding = WeatherProvider()
    @Published private(set) var currentWeatherSfSymbol: String?
    @Published private(set) var currentWeatherCondition: String?
    @Published private(set) var currentWeatherTemperature: String?
    @Published private(set) var isLoadingWeather: Bool = true
    @Published private(set) var isDaytime: Bool = true
    @Published private(set) var dayPartsForecast: [DaypartForecast] = []
    
    func fetchCurrentWeather() async {
        defer {
            isLoadingWeather = false
        }
        
        do {
            let (currentWeather, hourlyWeather) = try await weatherProvider.getTodaySnapshot()
            
            dayPartsForecast = hourlyWeather
            currentWeatherSfSymbol = currentWeather.symbolName
            currentWeatherCondition = currentWeather.conditionDescription
            isDaytime = currentWeather.isDaytime
            
            let tempInt = currentWeather.temperatureInt
            
            currentWeatherTemperature = "\(tempInt)°"
        }
        catch {
            showWeatherError()
        }
    }
    
    private func showWeatherError() {
        print("Unable to fetch weather")
    }
}

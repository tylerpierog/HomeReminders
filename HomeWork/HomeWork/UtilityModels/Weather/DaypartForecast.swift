import Foundation

struct DaypartForecast: Identifiable {
    enum Part: String { case morning, afternoon, evening, night }
    let id = UUID()
    let part: Part
    let symbolName: String
    let temperatureInt: Int
    let isDaylight: Bool
}

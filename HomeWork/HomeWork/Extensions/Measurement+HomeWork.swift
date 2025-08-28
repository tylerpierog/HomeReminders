import Foundation

extension Measurement where UnitType == UnitTemperature {
    var intForLocale: Int {
        let unit: UnitTemperature = (Locale.current.measurementSystem == .us) ? .fahrenheit : .celsius
        return Int(converted(to: unit).value.rounded())
    }
}

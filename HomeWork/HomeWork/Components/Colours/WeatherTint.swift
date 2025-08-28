import SwiftUI

enum WeatherTint {
    static func colors(for symbol: String, isDaylight: Bool = true) -> (Color, Color) {
        switch symbol {
        // Clear / sunny
        case "sun.max", "sun.max.fill":
            return isDaylight ? (.yellow, .orange) : (.indigo, .purple)

        // Partly cloudy
        case "cloud.sun", "cloud.sun.fill":
            return isDaylight ? (.yellow, .gray) : (.indigo, .gray)

        // Cloudy
        case "cloud", "cloud.fill":
            return (.gray, .gray.opacity(0.6))

        // Rain
        case "cloud.rain", "cloud.rain.fill",
             "cloud.heavyrain", "cloud.heavyrain.fill",
             "cloud.drizzle", "cloud.drizzle.fill":
            return (.blue, .gray)

        // Thunderstorms
        case "cloud.bolt", "cloud.bolt.fill",
             "cloud.bolt.rain", "cloud.bolt.rain.fill":
            return (.yellow, .blue)

        // Snow
        case "cloud.snow", "cloud.snow.fill", "snowflake":
            return (.cyan, .white)

        // Fog / haze
        case "cloud.fog", "cloud.fog.fill", "smoke.fill":
            return (.gray, .gray.opacity(0.5))

        // Windy
        case "wind", "wind.snow":
            return (.teal, .gray)

        // Hot / cold indicators
        case "thermometer.sun.fill":
            return (.orange, .red)
        case "thermometer.snowflake":
            return (.cyan, .blue)

        default:
            return (.primary, .secondary)
        }
    }
}

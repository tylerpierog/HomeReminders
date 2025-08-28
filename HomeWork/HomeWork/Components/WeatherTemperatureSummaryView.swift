import SwiftUI

struct WeatherTemperatureSummaryView: View {
    let weatherTitle: String
    let imageName: String
    let temperature: String
    let isDaylight: Bool
    
    var colours: (Color, Color) {
        WeatherTint.colors(for: imageName, isDaylight: isDaylight)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(weatherTitle.capitalizedFirst)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .symbolRenderingMode(.palette)
                .foregroundStyle(colours.0, colours.1)
            Text(temperature)
                .font(.title3)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
        }
    }
}

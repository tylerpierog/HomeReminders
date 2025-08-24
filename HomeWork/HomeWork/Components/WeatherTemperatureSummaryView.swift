import SwiftUI

struct WeatherTemperatureSummaryView: View {
    let weatherTitle: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(weatherTitle)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.black)
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(.yellow)
            Text("\(Int.random(in: 10...30))°")
                .font(.title3)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
        }
    }
}

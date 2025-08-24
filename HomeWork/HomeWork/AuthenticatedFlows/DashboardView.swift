import SwiftUI

struct DashboardView: View {
    let options = ["Morning", "Afternoon", "Evening", "Night"]
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HomeWorkBrandingHeaderView()
                    .padding(.bottom, 16)
                ScrollView {
                    weatherView
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundColour.ignoresSafeArea())
        }
    }
    
    private var weatherView: some View {
        VStack(spacing: 16) {
            todaysForecastGlanceView
            forecastCardsView
            progressView
            upcomingTasksSectionView
        }
    }
    
    private var todaysForecastGlanceView: some View {
        HStack(spacing: 20) {
            Image(systemName: "sun.max.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundStyle(.yellow)
            todaysTempAndDescriptionView
        }
    }
    
    private var todaysTempAndDescriptionView: some View {
        VStack(alignment: .leading) {
            Text("Sunny")
                .font(.headline)
                .fontWeight(.bold)
            Text("30°C")
                .font(.system(size: 40, weight: .semibold, design: .default))
        }
    }
    
    private var forecastCardsView: some View {
        HStack(spacing: 20) {
            ForEach(0..<4) { index in
                let title = options[index]
                WeatherTemperatureSummaryView(weatherTitle: title)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.all, 16)
        .background(.white)
        .cornerRadius(10)
    }
    
    private var progressView: some View {
        TaskProgressBarView()
    }
    
    private var upcomingTasksSectionView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Upcoming Tasks")
                    .font(.title3)
                    .fontWeight(.regular)
                Spacer()
            }
        }
    }
}

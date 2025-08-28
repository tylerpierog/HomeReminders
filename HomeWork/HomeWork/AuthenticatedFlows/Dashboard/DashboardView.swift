import SwiftUI

struct DashboardView: View {
    @ObservedObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HomeWorkBrandingHeaderView()
                    .padding(.bottom, 16)
                ScrollView {
                    weatherView
                    progressView
                        .padding(.top, 16)
                    upcomingTasksSectionView
                        .padding(.top, 16)
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundColour.ignoresSafeArea())
        }
        .task {
            await viewModel.fetchCurrentWeather()
        }
    }
    
    @ViewBuilder
    private var weatherView: some View {
        if viewModel.isLoadingWeather {
            ProgressView()
                .scaleEffect(1.2)
                .frame(width: 80, height: 80)
        } else {
            VStack(spacing: 16) {
                todaysForecastGlanceView
                forecastCardsView
            }
        }
    }
    
    @ViewBuilder
    private var todaysForecastGlanceView: some View {
        let (primary, secondary) = WeatherTint.colors(
            for: viewModel.currentWeatherSfSymbol ?? "sun.max.fill",
            isDaylight: viewModel.isDaytime)

        HStack(spacing: 20) {
            Image(systemName: viewModel.currentWeatherSfSymbol ?? "sun.max.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .symbolRenderingMode(.palette)
                .foregroundStyle(primary, secondary)
            todaysTempAndDescriptionView
        }
    }
    
    private var todaysTempAndDescriptionView: some View {
        VStack(alignment: .leading) {
            Text(viewModel.currentWeatherCondition ?? "Sunny")
                .font(.headline)
                .fontWeight(.bold)
            Text(viewModel.currentWeatherTemperature ?? "30°C")
                .font(.system(size: 40, weight: .semibold, design: .default))
        }
    }
    
    private var forecastCardsView: some View {
        HStack(spacing: 20) {
            ForEach(viewModel.dayPartsForecast) { forecast in
                WeatherTemperatureSummaryView(
                    weatherTitle: forecast.part.rawValue,
                    imageName: forecast.symbolName,
                    temperature: "\(forecast.temperatureInt)°",
                    isDaylight: forecast.isDaylight)
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
                Text(viewModel.upcomingTasksHeader)
                    .font(.title3)
                    .fontWeight(.regular)
                Spacer()
            }
        }
    }
}

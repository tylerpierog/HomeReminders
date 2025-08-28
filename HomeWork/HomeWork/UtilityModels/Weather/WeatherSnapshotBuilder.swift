import Foundation
import WeatherKit

struct WeatherSnapshotBuilder {
    enum Part: CaseIterable { case morning, afternoon, evening, night }

    func build(
        hourlyForecast: [HourWeather],
        now: Date = Date(),
        calendar: Calendar = .current
    ) throws -> (current: CurrentForecast, dayparts: [DaypartForecast]) {

        let (todayStart, twoDaysEnd) = try twoDayBounds(for: now, calendar: calendar)
        let hoursInWindow = hourlyForecast.filter { $0.date >= todayStart && $0.date < twoDaysEnd }

        guard let currentHour = currentHourWeather(from: hoursInWindow, calendar: calendar, now: now) else {
            throw WeatherError.noHourlyData
        }

        let currentForecast = CurrentForecast(
            symbolName: currentHour.symbolName,
            conditionDescription: currentHour.condition.description,
            temperatureInt: currentHour.temperature.intForLocale,
            isDaytime: currentHour.isDaylight
        )

        let sequence = nextFourParts(after: now, calendar: calendar)

        let dayparts = sequence.compactMap { (part, offset) -> DaypartForecast? in
            guard let rep = representative(for: part, from: hoursInWindow, calendar: calendar, now: now, dayOffset: offset) else {
                return nil
            }
            
            return DaypartForecast(
                part: mapPart(part),
                symbolName: rep.symbolName,
                temperatureInt: rep.temperature.intForLocale,
                isDaylight: rep.isDaylight)
        }

        return (currentForecast, dayparts)
    }

    func twoDayBounds(for date: Date, calendar: Calendar) throws -> (Date, Date) {
        let start = calendar.startOfDay(for: date)
        
        guard let end = calendar.date(byAdding: .day, value: 2, to: start) else {
            throw WeatherError.invalidDateRange
        }
        
        return (start, end)
    }

    func currentHourWeather(from hours: [HourWeather], calendar: Calendar, now: Date) -> HourWeather? {
        let currentHour = calendar.component(.hour, from: now)
       
        if let exact = hours.first(where: { calendar.component(.hour, from: $0.date) == currentHour }) {
            return exact
        }
        
        return hours.min { abs($0.date.timeIntervalSince(now)) < abs($1.date.timeIntervalSince(now)) }
    }

    func part(for date: Date, calendar: Calendar) -> Part {
        let h = calendar.component(.hour, from: date)
       
        return switch h {
        case 6..<12:  .morning
        case 12..<17: .afternoon
        case 17..<21: .evening
        default:      .night
        }
    }

    func nextFourParts(after now: Date, calendar: Calendar) -> [(Part, Int)] {
        let all = Part.allCases
        let current = part(for: now, calendar: calendar)
        
        guard let idx = all.firstIndex(of: current) else { return all.map { ($0, 0) } }

        var result: [(Part, Int)] = []
        var offset = 0
        
        for i in 1...4 {
            let j = (idx + i) % all.count
            if j == 0 { offset += 1 }
            result.append((all[j], offset))
        }
        
        return result
    }

    func hours(for part: Part, from hours: [HourWeather], calendar: Calendar, dayStart: Date) -> [HourWeather] {
        let nextStart = calendar.date(byAdding: .day, value: 1, to: dayStart)!
        switch part {
        case .morning:
            return hours.filter {
                $0.date >= dayStart && $0.date < nextStart &&
                (6..<12).contains(calendar.component(.hour, from: $0.date))
            }
        case .afternoon:
            return hours.filter {
                $0.date >= dayStart && $0.date < nextStart &&
                (12..<17).contains(calendar.component(.hour, from: $0.date))
            }
        case .evening:
            return hours.filter {
                $0.date >= dayStart && $0.date < nextStart &&
                (17..<21).contains(calendar.component(.hour, from: $0.date))
            }
        case .night:
            let late = hours.filter {
                $0.date >= dayStart && $0.date < nextStart &&
                (21..<24).contains(calendar.component(.hour, from: $0.date))
            }
            let earlyNextStart = nextStart
            let earlyNextEnd = calendar.date(byAdding: .day, value: 1, to: earlyNextStart)!
            let early = hours.filter {
                $0.date >= earlyNextStart && $0.date < earlyNextEnd &&
                (0..<6).contains(calendar.component(.hour, from: $0.date))
            }
            return late + early
        }
    }

    func representative(
        for part: Part,
        from allHours: [HourWeather],
        calendar: Calendar,
        now: Date,
        dayOffset: Int) -> HourWeather? {
        guard let targetDate = calendar.date(byAdding: .day, value: dayOffset, to: now) else { return nil }
            
        let targetDayStart = calendar.startOfDay(for: targetDate)

        let bucket = self.hours(for: part, from: allHours, calendar: calendar, dayStart: targetDayStart)
            
        guard !bucket.isEmpty else { return nil }

        if dayOffset == 0 {
            let future = bucket.filter { $0.date >= now }
            if !future.isEmpty { return future[future.count / 2] }
        }
            
        return bucket[bucket.count / 2]
    }

    func mapPart(_ p: Part) -> DaypartForecast.Part {
        switch p {
        case .morning:   return .morning
        case .afternoon: return .afternoon
        case .evening:   return .evening
        case .night:     return .night
        }
    }
}

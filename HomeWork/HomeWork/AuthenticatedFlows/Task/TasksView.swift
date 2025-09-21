import SwiftUI

enum TaskCategory: Int, CaseIterable {
    case indoor
    case outdoor
    
    var description: String {
        switch self {
        case .indoor: "Indoor"
        case .outdoor: "Outdoor"
        }
    }
}

struct TasksView: View {
    @EnvironmentObject var taskCoordinator: TaskCoordinator
    @State private var title: String = ""
    @State private var selectedCategory: TaskCategory = .indoor
    @State private var isWeatherDependentEnabled = false
    @State private var selectedDate: Date?
    @State private var isShowingCalendar = false
    @State private var selectedTime: Date?
    @State private var isShowingTime = false

    var body: some View {
        VStack {
            List {
                tileSectionView
                categorySectionView
                dateSectionView
                weatherDependentSectionView
            }
            
            Button("Press me") {
                taskCoordinator.goToConfirm()
            }
        }
        .navigationTitle("Add Task")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var datePlaceholder: String {
        if let date = selectedDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        } else {
            return "Select date"
        }
    }
    
    private var startTimePlaceholder: String {
        if let time = selectedTime {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: time)
        } else {
            return "Select time"
        }
    }

    private var tileSectionView: some View {
        Section {
            TextField("Task Title", text: $title)
        }
    }
    
    private var categorySectionView: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Category")
                    .font(.headline)
                    .padding(.vertical, 8)
                HStack {
                    Picker("Category", selection: $selectedCategory) {
                        Text(TaskCategory.indoor.description)
                            .font(.callout)
                            .fontWeight(.light)
                            .tag(TaskCategory.indoor)
                        Text(TaskCategory.outdoor.description)
                            .font(.callout)
                            .fontWeight(.light)
                            .tag(TaskCategory.outdoor)
                    }
                    .pickerStyle(.segmented)
                    .paletteSelectionEffect(.automatic)
                    .tint(Color.secondaryButtonColour)
                }
            }
        }
    }
    
    private var dateSectionView: some View {
        Section {
            selectDateView
            selectTimeView
        }
    }
    
    private var selectDateView: some View {
        ButtonWithLeftIconAndTextView(imageName: "calendar", text: .constant(datePlaceholder)) {
            isShowingCalendar = true
        }
        .sheet(isPresented: $isShowingCalendar) {
            VStack {
                calendarPickerView
                ButtonView(buttonText: "Done", buttonColour: Color.secondaryButtonColour) {
                    isShowingCalendar = false
                }
                .padding()
                .padding(.bottom, 24)
            }
            .presentationDetents([.medium])
        }
    }
    
    private var selectTimeView: some View {
        ButtonWithLeftIconAndTextView(imageName: "clock", text: .constant(startTimePlaceholder)) {
            isShowingTime = true
        }
        .sheet(isPresented: $isShowingTime) {
            VStack {
                timePickerView
                ButtonView(buttonText: "Done", buttonColour: Color.secondaryButtonColour) {
                    isShowingTime = false
                }
                .padding()
                .padding(.bottom, 24)
            }
            .presentationDetents([.medium])
        }
    }
    
    private var reminderView: some View {
        Section {
            ButtonWithLeftIconAndTextView(imageName: "clock", text: .constant("Time")) {
                //show sheet
            }
        }
    }
    
    private var weatherDependentSectionView: some View {
        Section {
            HStack {
                Text("Depends on weather")
                    .font(.subheadline)
                    .padding(.vertical, 8)
                Spacer()
                Toggle(isOn: $isWeatherDependentEnabled) {
                    EmptyView()
                }
                .tint(Color.secondaryButtonColour)
            }
        }
    }
    
    private var calendarPickerView: some View {
        DatePicker(
            "Select Date",
            selection: Binding(
                get: { selectedDate ?? Date() },
                set: { selectedDate = $0 }
            ),
            displayedComponents: .date)
        .datePickerStyle(.graphical)
        .id(selectedDate)
        .tint(.secondaryButtonColour)
        .padding()
        .padding(.top, 8)
    }
    
    private var timePickerView: some View {
        DatePicker(
            "",
            selection: Binding(
                get: { selectedTime ?? Date() },
                set: { selectedTime = $0 }
            ),
            displayedComponents: .hourAndMinute)
        .datePickerStyle(.wheel)
        .id(selectedDate)
        .tint(.secondaryButtonColour)
        .labelsHidden()
        .frame(maxWidth: .infinity)
        .clipped()
        .padding(.horizontal)
    }
}

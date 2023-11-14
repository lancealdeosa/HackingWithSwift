//
//  ContentView.swift
//  BetterRest
//
//  Created by Lance on 10/25/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
  @State private var wakeUpDate = defaultWakeTime
  @State private var sleepAmount = 8.0
  @State private var coffeeAmount = 1
  
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showingAlert = false
  
  static var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? .now
  }
  
  var body: some View {
    NavigationStack {
      Form {
        VStack(alignment: .leading, spacing: 0) {
          Text("When do you want to wake up?")
            .font(.headline)
          DatePicker("Enter a time", selection: $wakeUpDate, displayedComponents: .hourAndMinute)
            .labelsHidden()
        }
        
        VStack(alignment: .leading, spacing: 0) {
          Text("How much sleep do you want?")
            .font(.headline)
          Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25) { _ in
            // Do nothing
          }
        }
        
        VStack(alignment: .leading, spacing: 0) {
          Text("Daily coffee intake")
            .font(.headline)
          Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...20)
        }
       
        
//        Text(Date.now, format: .dateTime.hour().minute())
//        Text(Date.now, format: .dateTime.day().month().year())
//        Text(Date.now.formatted(date: .long, time: .shortened))
      }
      .navigationTitle("BetterRest")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        Button("Calculate", action: calculateBedtime)
      }
      .alert(alertTitle, isPresented: $showingAlert) {
        Button("OK") { }
      } message: {
        Text(alertMessage)
      }

    }
  }
  
  func calculateBedtime() {
    do {
      let config = MLModelConfiguration()
      let model = try SleepCalculator(configuration: config)
      
      let components = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: wakeUpDate)
      let hour = components.hour ?? 0
      let minute = components.minute ?? 0
      let hoursInSeconds = hour * 60 * 60
      let minuteInSeconds = minute * 60
      
      let prediction = try model.prediction(wake: Int64(hoursInSeconds + minuteInSeconds), estimatedSleep: sleepAmount, coffee: Int64(coffeeAmount))
      
//      let sleepTime = wakeUpDate - prediction.actualSleep
      
//      alertTitle = "Your ideal bedtime is…"
//      alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
      
      alertTitle = "You will actually wake up at..."
      
      var midnightWakeComponents = components
      midnightWakeComponents.hour = 0
      midnightWakeComponents.minute = 0
      
      if let midnightDate = Calendar.current.date(from: midnightWakeComponents) {
        let actualWakeUpDate = midnightDate + prediction.actualSleep
        alertMessage = actualWakeUpDate.formatted(date: .omitted, time: .shortened)
      } else {
        alertMessage = "💩💩💩"
      }
    } catch {
      alertTitle = "Error"
      alertMessage = "Sorry, there was a problem calculating your bedtime"
    }
    showingAlert = true
  }
}

#Preview {
  ContentView()
}

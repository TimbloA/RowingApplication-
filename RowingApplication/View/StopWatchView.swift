////
//  StopWatchView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 17/11/2024.
//

import SwiftUI

struct StopWatchView: View {
    @StateObject private var stopwatchViewModel = StopwatchViewModel.shared
    @State private var isStopped = false // Tracks if the stopwatch is stopped
    
    private var formattedTime: String {
        let minutes = Int(stopwatchViewModel.elapsedTime) / 60
        let seconds = Int(stopwatchViewModel.elapsedTime) % 60
        let milliseconds = Int((stopwatchViewModel.elapsedTime - floor(stopwatchViewModel.elapsedTime)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Elapsed Time")
                .font(.title)
            Text(formattedTime) // Display formatted time
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 20) {
                Button(action: {
                    stopwatchViewModel.start()
                    isStopped = false // Ensure the state resets when the stopwatch starts
                }) {
                    Text("Start")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    if isStopped {
                        stopwatchViewModel.reset()
                        isStopped = false // Reset state
                    } else {
                        stopwatchViewModel.stop()
                        isStopped = true // Indicate stopwatch has been stopped
                    }
                }) {
                    Text(isStopped ? "Reset" : "Stop")
                        .padding()
                        .foregroundColor(.white)
                        .background(isStopped ? Color.orange : Color.red)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    stopwatchViewModel.lap()
                }) {
                    Text("Lap")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            
            List {
                ForEach(Array(stopwatchViewModel.lapTimes.enumerated()), id: \.offset) { index, lapTime in
                    Text("Lap \(index + 1): \(lapTimeFormatted(lapTime))")
                }
            }
            
            RateCheckView()
        }
        .padding()
    }
    
    private func lapTimeFormatted(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time - floor(time)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}

#Preview {
    StopWatchView()
}



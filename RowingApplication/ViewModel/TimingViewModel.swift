//
//  TimingViewModel.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 17/11/2024.
//
import Foundation

class StopwatchViewModel: ObservableObject {
    static let shared = StopwatchViewModel()
    
    @Published var elapsedTime: TimeInterval = 0.0
    @Published var lapTimes: [TimeInterval] = []
    
    private var timer: Timer?
    private var lastUpdateTime: Date?
    private var cumulativeElapsedTime: TimeInterval = 0.0
    private var lastLapElapsedTime: TimeInterval = 0.0
    private var isRunning = false
    //start function
    func start() {
        if !isRunning {
            lastUpdateTime = Date()
            isRunning = true
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                let now = Date()
                if let lastUpdate = self.lastUpdateTime {
                    let updateDiff = now.timeIntervalSince(lastUpdate)
                    self.cumulativeElapsedTime += updateDiff
                    self.elapsedTime = self.cumulativeElapsedTime
                }
                self.lastUpdateTime = now
            }
        }
    }
    //stop function
    func stop() {
        if isRunning {
            if let lastUpdate = lastUpdateTime {
                let now = Date()
                let updateDiff = now.timeIntervalSince(lastUpdate)
                cumulativeElapsedTime += updateDiff
                elapsedTime = cumulativeElapsedTime
            }
            
            timer?.invalidate()
            timer = nil
            lastUpdateTime = nil
            isRunning = false
        }
    }
    //lap function
    func lap() {
        let currentElapsedTime = elapsedTime
        let lapTime = currentElapsedTime - lastLapElapsedTime
        lapTimes.append(lapTime)
        lastLapElapsedTime = currentElapsedTime
    }
    
    func reset() {
        stop()
        elapsedTime = 0.0
        cumulativeElapsedTime = 0.0
        lapTimes.removeAll()
        lastUpdateTime = nil
        lastLapElapsedTime = 0.0
    }
}

//
//  StopWatch.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 17/11/2024.
//

import Foundation


class Stopwatch: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0.0
    @Published var lapTimes: [TimeInterval] = []
    
    private var timer: Timer?
    private var startTime: Date?
    private var lastLapTime: Date?
    
    func start() {
        if timer == nil {
            startTime = Date()
            lastLapTime = startTime
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                guard let self = self, let startTime = self.startTime else { return }
                self.elapsedTime = Date().timeIntervalSince(startTime)
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    func lap() {
        guard let lastLapTime = lastLapTime else { return }
        let lapTime = Date().timeIntervalSince(lastLapTime)
        lapTimes.append(lapTime)
        self.lastLapTime = Date()
    }
    
    func reset() {
        stop()
        elapsedTime = 0.0
        lapTimes.removeAll()
        startTime = nil
        lastLapTime = nil
    }
}

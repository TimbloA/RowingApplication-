//
//  SeatRacingView.swift
//  RowingApplication
//
//  Created by Timblo, Adi (WING) on 19/11/2024.
//

import SwiftUI

struct SeatRacingView: View {
    @State private var racingCrews: [Crew] = []
    @State private var showingNewCrewView = false
    @State private var raceResults: [String] = []
    @State private var creatingForFirstCrew = true
    @State private var title: String = ""
    @State private var dataDate: Date = Date()
    
    // for manual swapping
    @State private var selectedAthlete1Index: Int?
    @State private var selectedAthlete2Index: Int?
    @State private var isSwapping = false
    
    // time for each crew
    @State private var crew1FirstStartTime = ""
    @State private var crew1FirstFinishTime = ""
    @State private var crew1SecondStartTime = ""
    @State private var crew1SecondFinishTime = ""
    @State private var crew2FirstStartTime = ""
    @State private var crew2FirstFinishTime = ""
    @State private var crew2SecondStartTime = ""
    @State private var crew2SecondFinishTime = ""
    
    //track if times have been entered
    @State private var hasEnteredPreSwapTimes = false
    @State private var hasEnteredPostSwapTimes = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    TextField("Title",text:$title)
                    DatePicker(
                        "Date:",
                        selection: $dataDate,
                        displayedComponents: [.date]
                    )
                }
                VStack(spacing: 20) {
                    HStack(spacing: 10) {
                        CrewCardWithSelection(
                            title: "Crew 1",
                            crew: racingCrews.count > 0 ? racingCrews[0] : nil,
                            selectedAthleteIndex: $selectedAthlete1Index,
                            onTap: {
                                creatingForFirstCrew = true
                                showingNewCrewView = true
                            }
                        )
                        
                        CrewCardWithSelection(
                            title: "Crew 2",
                            crew: racingCrews.count > 1 ? racingCrews[1] : nil,
                            selectedAthleteIndex: $selectedAthlete2Index,
                            onTap: {
                                creatingForFirstCrew = false
                                showingNewCrewView = true
                            }
                        )
                    }
                    .padding()
                    
                    if racingCrews.count == 2 {
                        //pre-swap time inputs
                        if !hasEnteredPreSwapTimes {
                            VStack(spacing: 5) {
                                Text("Pre-Swap Times")
                                    .font(.headline)
                                
                                GroupBox("Crew 1 Time") {
                                    Text("Start Time:")
                                    TimeInputView(timeTenths: $crew1FirstStartTime)
                                    Text("Finish Time:")
                                    TimeInputView(timeTenths: $crew1FirstFinishTime)
                                }.padding()
                                
                                GroupBox("Crew 2 Time") {
                                    Text("Start Time:")
                                    TimeInputView(timeTenths: $crew2FirstStartTime)
                                    Text("Finish Time:")
                                    TimeInputView(timeTenths: $crew2FirstFinishTime)
                                }.padding()
                                
                                Button("Confirm Pre-Swap Times") {
                                    hasEnteredPreSwapTimes = true
                                    let difference = abs((Double(crew1FirstFinishTime)!-Double(crew1FirstStartTime)!) - (Double(crew2FirstFinishTime)!-Double(crew2FirstStartTime)!))
                                    raceResults.append("Initial time difference: \(String(format: "%.1f", difference/10)) seconds")
                                }
                                .buttonStyle(.borderedProminent)
                                .disabled(crew1FirstStartTime.isEmpty || crew2FirstStartTime.isEmpty)
                            }
                            .padding()
                            
                        }
                        
                        //swap Controls
                        if hasEnteredPreSwapTimes && !hasEnteredPostSwapTimes {
                            Button(action: performSwap) {
                                Text("Swap Selected Athletes")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(canSwap ? Color.blue : Color.gray)
                                    .cornerRadius(10)
                            }
                            .disabled(!canSwap)
                            
                            // after-swap time inputs
                            VStack(spacing: 15) {
                                Text("Post-Swap Times")
                                    .font(.headline)
                                
                                GroupBox("Crew 1 Time") {
                                    Text("Start Time:")
                                    TimeInputView(timeTenths: $crew1SecondStartTime)
                                    Text("Finish Time:")
                                    TimeInputView(timeTenths: $crew1SecondFinishTime)
                                }
                                
                                GroupBox("Crew 2 Time") {
                                    Text("Start Time:")
                                    TimeInputView(timeTenths: $crew2SecondStartTime)
                                    Text("Finish Time:")
                                    TimeInputView(timeTenths: $crew2SecondFinishTime)                                }
                                
                                Button("Confirm Post-Swap Times") {
                                    hasEnteredPostSwapTimes = true
                                    calculateResults()
                                }
                                .buttonStyle(.borderedProminent)
                                .disabled(crew1SecondStartTime.isEmpty || crew2SecondStartTime.isEmpty)
                            }
                            .padding()
                        }
                    }
                    
                    // Results Display
                    if !raceResults.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Results")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ForEach(raceResults, id: \.self) { result in
                                Text(result)
                                    .padding(.horizontal)
                            }
                            
                            if hasEnteredPostSwapTimes && title != "" {
                                Button("Save Race") {
                                    DataManager.shared.seatRaces.append( SeatRace(title: title, data: raceResults,  dataDate: dataDate))
                                    resetRace()
                                    DataManager.shared.saveData()
                                }
                                .buttonStyle(.bordered)
                                .padding()
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Seat Racing")
            .sheet(isPresented: $showingNewCrewView) {
                NewCrewView { crew in
                    if creatingForFirstCrew {
                        if racingCrews.isEmpty {
                            racingCrews.append(crew)
                        } else {
                            racingCrews[0] = crew
                        }
                    } else {
                        if racingCrews.count < 2 {
                            racingCrews.append(crew)
                        } else {
                            racingCrews[1] = crew
                        }
                    }
                }
            }
        }
    }
    
    private var canSwap: Bool {
        selectedAthlete1Index != nil &&
        selectedAthlete2Index != nil &&
        racingCrews.count == 2 &&
        !isSwapping
    }
    
    private func performSwap () {
           guard let index1 = selectedAthlete1Index,
                 let index2 = selectedAthlete2Index,
                 racingCrews.count == 2 else { return }
           
           isSwapping = true
           
           //sore athlete names before swap for reference
           let athlete1Name = racingCrews[0].athletes[index1].name
           let athlete2Name = racingCrews[1].athletes[index2].name
           
           // Convert to SeatRaceCrew for the swap
           var raceCrew1 = SeatRaceCrew(athletes: racingCrews[0].athletes, raceTime: Double(crew1FirstStartTime)! / 10.0)
           var raceCrew2 = SeatRaceCrew(athletes: racingCrews[1].athletes, raceTime: Double(crew2FirstStartTime)! / 10.0)
           
           // perform the swap
           swapAthletes(crew1: &raceCrew1, crew2: &raceCrew2, athlete1Index: index1, athlete2Index: index2)
           
           // Update the actual crews
           racingCrews[0].athletes = raceCrew1.athletes
           racingCrews[1].athletes = raceCrew2.athletes
           
           raceResults.append("Swapped Athletes:")
           raceResults.append("- \(athlete1Name) moved to Crew 2")
           raceResults.append("- \(athlete2Name) moved to Crew 1")
           
           // Reset selection
           selectedAthlete1Index = nil
           selectedAthlete2Index = nil
           isSwapping = false
       }
       
       private func calculateResults() {
           guard let crew1FirstRunStart = Double(crew1FirstStartTime),
                 let crew1FirstRunFinish = Double(crew1FirstFinishTime),
                 let crew2FirstRunStart = Double(crew2FirstStartTime),
                 let crew2FirstRunFinish = Double(crew2FirstFinishTime),
                 let crew1SecondRunStart = Double(crew1SecondStartTime),
                 let crew1SecondRunFinish = Double(crew1SecondFinishTime),
                 let crew2SecondRunStart = Double(crew2SecondStartTime),
                 let crew2SecondRunFinish = Double(crew2SecondFinishTime) else { return }
           
           let crew1FirstRun = crew1FirstRunFinish - crew1FirstRunStart
           let crew2FirstRun = crew2FirstRunFinish - crew2FirstRunStart
           let crew1SecondRun = crew1SecondRunFinish - crew1SecondRunStart
           let crew2SecondRun = crew2SecondRunFinish - crew2SecondRunStart
           
           let crew1TimeChange = (crew1SecondRun - crew1FirstRun) / 10.0  // Convert to seconds
           let crew2TimeChange = (crew2SecondRun - crew2FirstRun) / 10.0
           
           raceResults.append("\nTime Changes After Swap:")
           raceResults.append("Crew 1: \(String(format: "%.1f", crew1TimeChange)) seconds")
           raceResults.append("Crew 2: \(String(format: "%.1f", crew2TimeChange)) seconds")
           
           // Analyze which crew improved more
           if crew1TimeChange < crew2TimeChange {
               raceResults.append("\nResults:")
               raceResults.append("Crew 1's new athlete performed better")
               raceResults.append("Improvement margin: \(String(format: "%.1f", abs(crew2TimeChange - crew1TimeChange))) seconds")
           } else if crew2TimeChange < crew1TimeChange {
               raceResults.append("\nResults:")
               raceResults.append("Crew 2's new athlete performed better")
               raceResults.append("Improvement margin: \(String(format: "%.1f", abs(crew1TimeChange - crew2TimeChange))) seconds")
           } else {
               raceResults.append("\nResults:")
               raceResults.append("Both athletes had equal impact on their new crews")
           }
       }
    
    private func resetRace() {
        // Reset times
        crew1FirstStartTime = ""
        crew1FirstFinishTime = ""
        crew1SecondStartTime = ""
        crew1SecondFinishTime = ""
        crew2FirstStartTime = ""
        crew2FirstFinishTime = ""
        crew2SecondStartTime = ""
        crew2SecondFinishTime = ""
        
        // Reset states
        hasEnteredPreSwapTimes = false
        hasEnteredPostSwapTimes = false
        raceResults.removeAll()
        selectedAthlete1Index = nil
        selectedAthlete2Index = nil
        
        // Reset crews
        racingCrews.removeAll()
    }
}

import SwiftUI

struct RootDataView: View {
    var single: Bool
    var singleAthlete: String
    
    enum DataType: String, CaseIterable, Identifiable {
        case training = "Training"
        case erg = "Erg"
        case pairsMatrix = "Pairs Matrix"
        case seatRacing = "Seat Racing"
        var id: Self { self }
    }
    
    @State private var dataChoice: DataType = .training
    
    var body: some View {
        VStack {
            Picker("Data Type:", selection: $dataChoice) {
                ForEach(DataType.allCases) { dataType in
                    Text(dataType.rawValue).tag(dataType)
                }
            }
            .pickerStyle(SegmentedPickerStyle()) 
            
            if dataChoice == .training {
                TrainingDataListView()
            } else if dataChoice == .erg {
                ErgDataListView(Single: single, SingleAthlete: singleAthlete)
            } else if dataChoice == .pairsMatrix {
                PairsMatrixListView(singleAthlete: singleAthlete, isSingle: single)
            } else if dataChoice == .seatRacing{
                SeatRacingListView()
            }
        }
        .padding() // Add padding for better layout
    }
}

#Preview {
    RootDataView(single: false, singleAthlete: "")
}

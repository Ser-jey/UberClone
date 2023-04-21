//
//  MapViewActionButton.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 06.12.2022.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var mapState: MapViewState
    @EnvironmentObject var vm: LocationSearchViewModel
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: Color(.darkGray) ,radius: 3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            print("DEBUG: No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locaitonSelected, .polylineAdded:
            mapState = .noInput
            vm.selectedUberLocation = nil
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
           return "line.3.horizontal"
        case .searchingForLocation,  .locaitonSelected, .polylineAdded:
           return "arrow.left"
        }
    }
    
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.searchingForLocation))
    }
}

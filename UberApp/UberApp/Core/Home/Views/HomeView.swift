//
//  HomeView.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 04.12.2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                

                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState)
                } else if mapState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                MapViewActionButton(mapState: $mapState)
                    .padding(.leading, 25)
            }

            if mapState == .locaitonSelected || mapState == .polylineAdded {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
                
        }
        .onReceive(LocationManager.shared.$userLocation, perform: { location in
            if let location = location {
                locationSearchVM.userLocation = location
            }
        })
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LocationSearchViewModel())
    }
}

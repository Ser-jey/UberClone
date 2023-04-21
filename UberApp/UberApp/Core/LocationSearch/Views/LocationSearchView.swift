//
//  LocationSearchView.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 09.12.2022.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText = ""
    @State private var destinationLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack {
            // header view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Circle()
                        .fill(Color.theme.primaryTextColor)
                        .frame(width: 6, height: 6)
               }
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGray5))
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
        Divider()
                .padding(.vertical)
            
            // list view
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle )
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    viewModel.selectLocation(result)
                                    mapState = .locaitonSelected
                                }
                            }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
            .environmentObject(LocationSearchViewModel())
    }
}

//
//  RideRequestView.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 16.12.2022.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationSearchVM: LocationSearchViewModel
    var body: some View {
        VStack {
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            // trip info view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill(Color.theme.primaryTextColor)
                        .frame(width: 8, height: 8)
                }
                
                
                VStack {
                    HStack {
                        Text("Current location")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(locationSearchVM.pickupTime ?? "")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 29)
                   
                    HStack {
                        if let location = locationSearchVM.selectedUberLocation {
                            Text(location.title)
                                .foregroundColor(Color.theme.primaryTextColor)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                        }
                        Spacer()
                        
                        Text(locationSearchVM.dropOffTime ?? "")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)

                    }
                }
                .padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            
            // ride type selectoion
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(RideType.allCases) { type in
                        VStack(alignment: .leading) {
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                   
                                
                                Text(locationSearchVM.computeRidePrice(forType: type).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .foregroundColor(selectedRideType == type ? .white : Color.theme.primaryTextColor)
                            .padding()
                        }
                        .frame(width: UIScreen.main.bounds.width / 3 - 19, height: 145)
                        .background(selectedRideType == type ? .blue : Color.theme.secondaryBackgroundColor)
                        .scaleEffect(selectedRideType == type ? 1.2 : 1)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedRideType = type
                            }
                        }
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
            
            // payment option view
            HStack {
                Text("Visa")
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                    
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .padding()
                    
            }
            .frame(height: 50)
            .background(Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
         
            // request ride button
            
            Button {
                
            } label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

        }
        .padding(.bottom, 20)
        .background(Color.theme.backgroundColor)
        .cornerRadius(16)

    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
            .environmentObject(LocationSearchViewModel())
    }
}

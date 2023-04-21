//
//  LocationSearchResultCell.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 13.12.2022.
//

import SwiftUI

struct LocationSearchResultCell: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text("\(title)")
                    .font(.body)

                Text("\(subtitle)")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.vertical, 5)
            .padding(.leading, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(title: "Sturbucks", subtitle: "123 Main Street")
    }
}

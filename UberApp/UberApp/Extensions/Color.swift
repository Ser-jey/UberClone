//
//  Color.swift
//  UberApp
//
//  Created by Сергей Кривошеев on 02.01.2023.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}

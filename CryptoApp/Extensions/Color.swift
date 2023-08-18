//
//  Color.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 03.07.2023..
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct ColorTheme2 {
    let accent = Color.green
    let background = Color.blue
    let green = Color.pink
    let red = Color.red
    let secondaryText = Color.teal
}

struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}

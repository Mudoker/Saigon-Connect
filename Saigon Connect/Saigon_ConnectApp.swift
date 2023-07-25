//
//  Saigon_ConnectApp.swift
//  Saigon Connect
//
//  Created by Quoc Doan Huu on 18/07/2023.
//

import SwiftUI

@main
struct Saigon_ConnectApp: App {
    @StateObject var themeManager = ThemeManager()
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}

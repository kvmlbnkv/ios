//
//  WeatherAppKBApp.swift
//  WeatherAppKB
//
//  Created by Użytkownik Gość on 06/05/2021.
//

import SwiftUI

@main
struct WeatherAppKBApp: App {
    var viewModel = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}

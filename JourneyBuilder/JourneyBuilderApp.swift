//
//  JourneyBuilderApp.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import SwiftUI

@main
struct JourneyBuilderApp: App {
    
    @StateObject var model = MockModel() as Model
    
    var body: some Scene {
        WindowGroup {
            TabNavigationView()
                .environmentObject(model)
        }
    }
}

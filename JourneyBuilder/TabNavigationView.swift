//
//  TabNavigationView.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import SwiftUI

struct TabNavigationView: View {
    
    @EnvironmentObject var model: Model
    
    var body: some View {
        TabView {
            ContentView().tabItem {
                Label("Journey", systemImage: "person")
            }
            CourseSignUpView().tabItem {
                Label("Sign Up", systemImage: "person")
            }
        }
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView()
            .environmentObject(MockModel())
    }
}

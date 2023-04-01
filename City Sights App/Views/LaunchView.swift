//
//  ContentView.swift
//  City Sights App
//
//  Created by Bryan Huang on 3/23/23.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        VStack {
            // Detect the authorization status of geolocating the user
            if model.authorizationState == .notDetermined {
                // if undetermined, show onboarding
                
            }
            else if model.authorizationState == .authorizedAlways ||
                        model.authorizationState == .authorizedWhenInUse {
                
                // if approved, show home view
                HomeView()
            }
            
            // if denied, show denied view
        }
        .padding()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ContentModel())
    }
}

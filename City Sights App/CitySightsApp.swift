//
//  City_Sights_AppApp.swift
//  City Sights App
//
//  Created by Bryan Huang on 3/23/23.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}

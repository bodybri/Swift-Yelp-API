//
//  HomeView.swift
//  City Sights App
//
//  Created by Bryan Huang on 3/31/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            // determine if we should show list or map
            if !isMapShowing {
                
                // Show list
                VStack {
                    HStack {
                        Image(systemName: "location")
                        Text("San Francisco")
                        Spacer()
                        Text("switch to map view")
                    }
                    Divider()
                    BusinessList()
                }
            }
            else {
                // show map
                
            }
            
        }
        else {
            // so spinner while waiting for data
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}

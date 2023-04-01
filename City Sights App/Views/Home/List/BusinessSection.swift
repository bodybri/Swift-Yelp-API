//
//  BusinessSection.swift
//  City Sights App
//
//  Created by Bryan Huang on 4/1/23.
//

import SwiftUI

struct BusinessSection: View {
    
    var title: String
    var businesses: [Business]
    
    var body: some View {
        Section (header: BusinessSectionHeader(title: title).bold()) {
            ForEach(businesses) { business in
                Text(business.name ?? "")
                Divider()
            }
            
        }
    }
}

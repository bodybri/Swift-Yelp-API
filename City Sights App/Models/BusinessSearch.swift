//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by Bryan Huang on 3/27/23.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}

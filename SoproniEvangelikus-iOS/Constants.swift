//
//  Constants.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 22..
//  Copyright © 2019. admin. All rights reserved.
//

import Foundation
import Firebase

struct Constants {
    
    static let locations: [String] = ["Church","CongregationHouse"]
    static let churchLocation = GeoPoint(latitude: 47.685276, longitude: 16.589422)
    static let congregationHouseLocation = GeoPoint(latitude: 47.685263, longitude:16.588625)
    static let aDayInMilliseconds:Double = 86400000
    
}

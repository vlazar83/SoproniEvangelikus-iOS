//
//  EventLocation.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 22..
//  Copyright © 2019. admin. All rights reserved.
//

import MapKit
import Contacts

class EventLocation: NSObject, MKAnnotation {
  let title: String?
  let locationName: String
  let coordinate: CLLocationCoordinate2D
  
  init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate
    
    super.init()
  }
  
  var subtitle: String? {
    return locationName
  }
}

//
//  Event.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 20..
//  Copyright © 2019. admin. All rights reserved.
//

import UIKit
import Firebase

class Event {
    
    init(comments: String, eventDateAndTime: Timestamp, fullName: String, location: GeoPoint, name: String, pastorName: String, typeOfEvent: String, withCommunion: Bool) {
        self.comments = comments
        self.eventDateAndTime = eventDateAndTime
        self.fullName = fullName
        self.location = location
        self.name = name
        self.pastorName = pastorName
        self.typeOfEvent = typeOfEvent
        self.withCommunion = withCommunion
    }
    
    //MARK: Properties
    
    var comments: String
    var eventDateAndTime: Timestamp
    var fullName: String
    var location: GeoPoint
    var name: String
    var pastorName: String
    var typeOfEvent: String
    var withCommunion: Bool


    
}

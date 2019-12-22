//
//  EventDetailsViewController.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 21..
//  Copyright © 2019. admin. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import Firebase

class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventFullNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventTimeLabel: UILabel!
    @IBOutlet weak var eventPastorNameLabel: UILabel!
    @IBOutlet weak var eventWithCommunionSwitch: UISwitch!
    @IBOutlet weak var eventLocationMapView: MKMapView!
    @IBOutlet weak var eventCommentsTextView: UITextView!
    
    var event: Event?
    
    let churchLocation = GeoPoint(latitude: 47.685276, longitude: 16.589422)
    let congregationHouseLocation = GeoPoint(latitude: 47.685263, longitude:16.588625)
    
    override func viewDidLoad(){
        super.viewDidLoad()

        eventNameLabel?.text = event?.name
        eventFullNameLabel?.text = event?.fullName
        eventPastorNameLabel?.text = event?.pastorName
        eventCommentsTextView?.text = event?.comments
        eventWithCommunionSwitch?.isOn = event!.withCommunion
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: (event?.eventDateAndTime.dateValue())!)
        let dateAndTimeArray = myString.components(separatedBy:" ")
        
        eventDateLabel?.text = dateAndTimeArray[0]
        eventTimeLabel?.text = dateAndTimeArray[1]

        let eventLocationCoordinates = CLLocation(latitude: (event?.location.latitude)!, longitude: (event?.location.longitude)!)

        centerMapOnLocation(location: eventLocationCoordinates)
        
        // decide event location for title setup in the next step
        var location: String = ""
        if(eventLocationCoordinates.coordinate.latitude == churchLocation.latitude && eventLocationCoordinates.coordinate.longitude == churchLocation.longitude){
            
            location = "Church"
        } else {
            location = "Congregation House"
        }
        
        let eventLocation = EventLocation(title: location,
          locationName: "Event Location",
          coordinate: eventLocationCoordinates.coordinate)
        eventLocationMapView.addAnnotation(eventLocation)
    }
    
    let regionRadius: CLLocationDistance = 100
    func centerMapOnLocation(location: CLLocation) {
      let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
        regionRadius, regionRadius)
      eventLocationMapView.setRegion(coordinateRegion, animated: true)
    }
    
}

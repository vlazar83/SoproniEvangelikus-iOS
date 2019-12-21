//
//  EventDetailsViewController.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 21..
//  Copyright © 2019. admin. All rights reserved.
//

import UIKit
import MapKit

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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        eventNameLabel?.text = event?.name
        eventFullNameLabel?.text = event?.fullName
        eventPastorNameLabel?.text = event?.pastorName
        eventCommentsTextView?.text = event?.comments
        eventWithCommunionSwitch?.isOn = event!.withCommunion
    }
    
}

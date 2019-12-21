//
//  EventDetailsViewController.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 21..
//  Copyright © 2019. admin. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventFullNameLabel: UILabel!
    
    var event: Event?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        eventNameLabel?.text = event?.name
        eventFullNameLabel?.text = event?.fullName
    }
    
}

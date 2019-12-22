//
//  CreateEventViewController.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 22..
//  Copyright © 2019. admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class CreateEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventFullNameTextField: UITextField!
    @IBOutlet weak var eventTypeTextField: UITextField!
    @IBOutlet weak var eventPastorNameTextField: UITextField!
    @IBOutlet weak var eventWithCommunionSwitcher: UISwitch!
    @IBOutlet weak var eventDateAndTimePicker: UIDatePicker!
    @IBOutlet weak var eventLocationPickerView: UIPickerView!
    @IBOutlet weak var eventCommentsTextField: UITextView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        eventLocationPickerView.delegate = self
        eventLocationPickerView.dataSource = self
    }
    
    @IBAction func createEventButton(_ sender: Any) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.locations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.locations[row]
    }
    
}

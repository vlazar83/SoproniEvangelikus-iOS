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
        
        let timeStampInFirebaseFormat = Timestamp(date: eventDateAndTimePicker.date)
        let locationForEvent = eventLocationPickerView.selectedRow(inComponent: 0)
        var locationForEventAsGeoPoint : GeoPoint
        if(locationForEvent == 0){
            locationForEventAsGeoPoint = Constants.churchLocation
        }else {
            locationForEventAsGeoPoint = Constants.congregationHouseLocation
        }
        
        let db = Firestore.firestore()
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("events").addDocument(data: [
            "eventDateAndTime": timeStampInFirebaseFormat,
            "comments": eventCommentsTextField.text!,
            "name": eventNameTextField.text!,
            "location": locationForEventAsGeoPoint,
            "typeOfEvent": eventTypeTextField.text!,
            "pastorName": eventPastorNameTextField.text!,
            "withCommunion": eventWithCommunionSwitcher.isOn,
            "fullName": eventFullNameTextField.text!,
            
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                let messageVC = UIAlertController(title: "Result", message: "Event Created successfully" , preferredStyle: .actionSheet)
                self.present(messageVC, animated: true) {
                                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                                    messageVC.dismiss(animated: true, completion: nil)})}
            }
        }
        
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

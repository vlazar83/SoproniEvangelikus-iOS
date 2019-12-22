//
//  ViewController.swift
//  SoproniEvangelikus-iOS
//
//  Created by admin on 2019. 12. 13..
//  Copyright © 2019. admin. All rights reserved.
//

import UIKit
import FirebaseUI
import GoogleSignIn

class ViewController: UIViewController, FUIAuthDelegate, UITableViewDelegate, UITableViewDataSource {

    // MARK: Properties
    fileprivate var _refHandle: DatabaseHandle!
    fileprivate var _authHandle: AuthStateDidChangeListenerHandle!
    var user: User?
    var displayName = "Anonymous"
    var eventsArray = [Event]()
    var eventForSegue : Event?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureAuth()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Firebase Auth and DB related methods
    
    func configureAuth(){
        
        let provider: [FUIAuthProvider] = [FUIGoogleAuth(), FUIEmailAuth()]
        FUIAuth.defaultAuthUI()?.providers = provider
        
        // listen for changes in the authorization state
        _authHandle = Auth.auth().addStateDidChangeListener { (auth: Auth, user: User?) in
            // refresh table data
            //self.messages.removeAll(keepingCapacity: false)
            //self.messagesTable.reloadData()
            
            // check if there is a current user
            if let activeUser = user {
                // check if the current app user is the current FIRUser
                if self.user != activeUser {
                    self.user = activeUser
                    self.signedInStatus(isSignedIn: true)
                    let name = user!.email!.components(separatedBy: "@")[0]
                    self.displayName = name
                    
                    // after successful login read the documents from Firestore
                    self.readDataFromFireStore()
                    
                }
            } else {
                // user must sign in
                self.signedInStatus(isSignedIn: false)
                self.loginSession()
            }
        }
    }
    
    func signedInStatus(isSignedIn: Bool) {
        /*
        signInButton.isHidden = isSignedIn
        signOutButton.isHidden = !isSignedIn
        messagesTable.isHidden = !isSignedIn
        messageTextField.isHidden = !isSignedIn
        sendButton.isHidden = !isSignedIn
        imageMessage.isHidden = !isSignedIn
        backgroundBlur.effect = UIBlurEffect(style: .light)
        
        if isSignedIn {
            // remove background blur (will use when showing image messages)
            messagesTable.rowHeight = UITableViewAutomaticDimension
            messagesTable.estimatedRowHeight = 122.0
            backgroundBlur.effect = nil
            messageTextField.delegate = self
            subscribeToKeyboardNotifications()
            configureDatabase()
            configureStorage()
            configureRemoteConfig()
            fetchConfig()
        }*/
    }
    
    func loginSession() {
        let authViewController = FUIAuth.defaultAuthUI()!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
    
    func readDataFromFireStore(){
        let db = Firestore.firestore()
        db.collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let event = Event(comments: document.data()["comments"] as! String,
                                      eventDateAndTime: document.data()["eventDateAndTime"] as! Timestamp,
                                      fullName: document.data()["fullName"] as! String,
                                      location: document.data()["location"] as! GeoPoint,
                                      name: document.data()["name"] as! String,
                                      pastorName: document.data()["pastorName"] as! String,
                                      typeOfEvent: document.data()["typeOfEvent"] as! String,
                                      withCommunion: (document.data()["withCommunion"] as! NSNumber).boolValue)
                                      
                    self.eventsArray += [event]
                    
                }
                // reload the data
                self.tableView.reloadData()
            }
        }
        
    }
    
    //MARK: UI interaction
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        // present the login screen again.
        configureAuth()
        
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
    }

    //MARK: TableView related methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell  else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }
        // Configure the cell...
        
        // Fetches the appropriate event for the data source layout.
        let event = eventsArray[indexPath.row]
        
        cell.eventNameLabel.text = event.name
        cell.eventFullNameLabel.text = event.fullName

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!");

        // here we get the cell from the selected row.
        //var selectedCell: EventTableViewCell
        //selectedCell=tableView.cellForRow(at: indexPath)! as! EventTableViewCell
        
        // here we prepare the data for transmission using a segue
        eventForSegue = eventsArray[indexPath.row]
        
        self.performSegue(withIdentifier: "EventDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is EventDetailsViewController
        {
            let vc = segue.destination as? EventDetailsViewController
            // pass the event from the selected row o EventDetailsView
            vc?.event = eventForSegue
        }
    }
    
}

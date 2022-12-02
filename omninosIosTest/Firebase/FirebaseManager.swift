//
//  FirebaseManager.swift
//  omninosIosTest
//
//  Created by Prince 2.O on 01/12/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct FirebaseManager {
    
    static private let db = Firestore.firestore()
    
    static func login(email: String, password: String, view: UIView, failure: @escaping (String) -> Void)
    {
        Auth.auth().signIn(withEmail: email, password: password) { _ , error in
            guard error == nil else {
                failure(error!.localizedDescription)
                return
            }
            progressHUD.stopSpinner()
            view.isUserInteractionEnabled = true
        }
    }
    
    static func logout(view: UIView)
    {
        let firebaseAuth = Auth.auth()
        do
        {
            try firebaseAuth.signOut()
            progressHUD.stopSpinner()
            view.isUserInteractionEnabled = true
        }
        catch let signOutError as NSError
        {
            progressHUD.stopSpinner()
            view.isUserInteractionEnabled = true
            debugPrint("SignOut Failed Reason: \(signOutError)")
        }
    }
    
    static func register(email: String, password: String, failure: @escaping (String) -> Void, success: @escaping () -> Void)
    {
        Auth.auth().createUser(withEmail: email, password: password) { _ , error in
            guard error == nil else {
                failure(error!.localizedDescription)
                return
            }
            success()
        }
    }
    
    static func forgotPassword(email: String, failure: @escaping (String) -> Void, success: @escaping () -> Void)
    {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                failure(error!.localizedDescription)
                return
            }
            success()
        }
    }
    
    static func saveData(email: String, name: String, phoneNo: String, password: String, success: @escaping (String) -> Void)
    {
        var ref: DocumentReference? = nil
        ref = self.db.collection(Constants.fbCN).addDocument(data: [
            "Email": email,
            "Name": name,
            "Phone No": phoneNo,
            "Password": password,
        ]) { err in
            guard err == nil else {
                debugPrint("Failed to Save Data to DB Reason : \(err!)")
                return
            }
            success(ref!.documentID)
        }
    }
    
    static func readData(docID: String)
    {
        self.db.collection(Constants.fbCN).document(docID).getDocument { (snapShot, error) in
            if let document = snapShot, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("User Data: \(dataDescription) Of DocID \(docID)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    static func checkAuthState(loggedIn: @escaping () -> Void, loggedOut: @escaping () -> Void)
    {
        Auth.auth().addStateDidChangeListener { _, user in
            
            // User is Logged In
            if (user != nil) {
               loggedIn()
            } else { // User is Logged Out
                loggedOut()
            }
        }
    }
}

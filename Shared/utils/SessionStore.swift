//
//  SessionStore.swift
//  swifftui-firebase-chat (iOS)
//
//  Created by Abdullah Ridwan on 5/28/21.
// we create the user model and

import Foundation
import FirebaseAuth


// User Model
struct User {
    var uid: String
    var email: String
}

//Session Store observable Object
class SessionStore: ObservableObject{
    @Published var currentUser: User?
    @Published var isAnon: Bool = false
    
    var handle: AuthStateDidChangeListenerHandle?
    var authRef = Auth.auth()
    
    
    /** [listen] mounts a listener; attaches a handler to authentication for Firebase updates */
    func listen(){
        handle = authRef.addStateDidChangeListener({ (auth, user) in
            if let user = user {
                //user is logged in
                self.isAnon = false
                self.currentUser = User(uid: user.uid, email: user.email!)
            }else{
                //user is not logged in
                self.isAnon = true
                self.currentUser = nil
            }
        })
    }
    
    func unbind(){
        if let handle = handle {
            authRef.removeStateDidChangeListener(handle)
        }
    }
    
    /** [signIn] signs the user in using authentication reference */
    func signIn(email: String, password: String){
        authRef.signIn(withEmail: email, password: password)
    }
    
    /**[signUp] creates a unique User account */
    func signUp(email: String, password:String){
        authRef.createUser(withEmail: email, password: password)
    }
    
    
    /** [signOut] return true if a user is sucessfully signed out */
    func signOut() -> Bool {
        do{
            try authRef.signOut()
            self.currentUser = nil
            self.isAnon = true
            return true
        }catch{
            return false
        }
    }
    
    
}


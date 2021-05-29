//
//  swifftui_firebase_chatApp.swift
//  Shared
//
//  Created by Abdullah Ridwan on 5/28/21.
//

import SwiftUI
import Firebase

@main
struct swifftui_firebase_chatApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    
}




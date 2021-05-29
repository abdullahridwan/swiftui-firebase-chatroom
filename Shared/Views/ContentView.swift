//
//  ContentView.swift
//  Shared
//
//  Created by Abdullah Ridwan on 5/28/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var sessionStore = SessionStore()
    
    init(){
        sessionStore.listen()
    }
    
    
    var body: some View {
        ChatList()
            .fullScreenCover(isPresented: $sessionStore.isAnon, content: {
                Login()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ChatroomViewModel())
    }
}

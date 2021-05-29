//
//  ChatroomViewModel.swift
//  swifftui-firebase-chat (iOS)
//
//  Created by Abdullah Ridwan on 5/28/21.
//

import Foundation
import Firebase

//create Model
struct Chatroom: Codable, Identifiable{
    var id: String
    var joinCode: Int
    var title: String
}



class ChatroomViewModel: ObservableObject{
    @Published var chatrooms = [Chatroom]()
    private let db = Firestore.firestore()
    private let user = Auth.auth().currentUser
    
    
    func fetchData(){
        if (user != nil){
            print(user!.uid)
            db.collection("chatrooms").whereField("users", arrayContains: user!.uid).addSnapshotListener({(snapshot, error) in
                //get respective documents
                guard let documents = snapshot?.documents else{
                    print("No documents recieved")
                    return
                }
                
                //create chatroom objects with documents
                self.chatrooms = documents.map({documentSnapshot -> Chatroom in
                    let data = documentSnapshot.data()
                    let id = documentSnapshot.documentID
                    print("The Id is: \(id)")
                    let joinCode = data["joinCode"] as? Int ?? -1
                    let title = data["title"] as? String ?? ""
                    return Chatroom(id: id, joinCode: joinCode, title: title)
                })
            })
        }
    }
    
    
    
    
    
}

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
    
    // handler is a functin we can call after the data is stored in the database. hence, it is escaping
    func createChatroom(title:String, handler: @escaping () -> Void){
        if(user != nil){
            db.collection("chatrooms").addDocument(data: [
                "joinCode": Int.random(in: 1000000..<5000000),
                "title": title,
                "users": [user!.uid]
            ]){err in
                if let err = err {
                    print("error in file [ChatroomViewModel.swift], function [createChatroom], \(err)")
                }else{
                    handler()
                }
            }
        }
    }
    
    func joinChatroom(joinCode: String, handler: @escaping () -> Void){
        if (user != nil){
            db.collection("chatrooms").whereField("joinCode", isEqualTo: Int(joinCode) ?? -1).getDocuments(){(snapshot, err) in
                if let err = err {
                    print("error: \(err)")
                }else{
                    for document in snapshot!.documents{
                        self.db.collection("chatrooms").document(document.documentID).updateData(["users": FieldValue.arrayUnion([self.user!.uid])])
                        handler()
                    }
                }
            }
        }
    }
    
    
    
    
}

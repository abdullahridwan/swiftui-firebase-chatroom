//
//  ChatList.swift
//  swifftui-firebase-chat (iOS)
//
//  Created by Abdullah Ridwan on 5/28/21.
//

import SwiftUI

struct ChatList: View {
    @ObservedObject var viewModel = ChatroomViewModel()
    init(){
        viewModel.fetchData()
        print("Data Fetched")
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(viewModel.chatrooms){chatroom in
                    HStack{
                        Image(systemName: "bubble.left.and.bubble.right")
                            .foregroundColor(.blue)
                        Text(chatroom.title)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Chatrooms")
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}

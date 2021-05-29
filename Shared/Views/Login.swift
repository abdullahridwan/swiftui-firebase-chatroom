//
//  Login.swift
//  swifftui-firebase-chat (iOS)
//
//  Created by Abdullah Ridwan on 5/28/21.
//

import SwiftUI

struct Login: View {

    @State var email = ""
    @State var password = ""
    @ObservedObject var currentSession = SessionStore()
    
    var body: some View {
        NavigationView{
            VStack{
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .padding()
                VStack{
                    TextField("Email", text: $email)
                        .modifier(FieldModifers())
                    SecureField("Password", text: $password)
                        .modifier(FieldModifers())
                    Button(action: {
                        currentSession.signIn(email: email, password: password)
                    }, label: {
                        Text("Log In")
                    }).buttonStyle(GrowingButton())
                    Spacer()
                        .frame(height: 10)
                    Button(action: {
                        currentSession.signUp(email: email, password: password)
                    }, label: {
                        Text("Create an Account")
                    }).buttonStyle(GrowingButton())
                }
                Spacer()
            }
            .navigationTitle("Login Page")
        }
    }
}


struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 200, height: 45)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2))
    }
}

struct FieldModifers: ViewModifier{
    func body(content: Content) -> some View{
        return content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

//
//  SignUpView.swift
//  Randodad
//
//  Created by Brian Clow on 11/2/20.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var username = ""
    @State var email = ""
    @State var password = ""


    var body: some View {
        VStack {
            Text("Randodad")
                .font(.largeTitle)

            Spacer()
            
            TextField("Username", text: $username)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Email", text: $email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Sign Up", action: {
                sessionManager.signUp(username: username, email: email, password: password)
            })
            
            Spacer()
            Button("Already have an account? Log in.", action: sessionManager.showLogin)
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

//
//  LoginView.swift
//  Randodad
//
//  Created by Brian Clow on 11/2/20.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    @State var username = ""
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
                
            SecureField("Password", text: $password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Login", action: {
                sessionManager.login(
                    username: username,
                    password: password
                )
            })
            
            Spacer()
            Button("Don't have an account? Sign up.", action: sessionManager.showsignUp)
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

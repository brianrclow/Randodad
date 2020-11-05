//
//  RandodadApp.swift
//  Randodad
//
//  Created by Brian Clow on 11/2/20.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct RandodadApp: App {
    
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
    }
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState {
            case .login:
                LoginView()
                    .environmentObject(sessionManager)

            case .signUp:
                SignUpView()
                    .environmentObject(sessionManager)

            case .confirmCode(let username):
                ConfirmationView(username: username)
                    .environmentObject(sessionManager)

            case .session(let user):
                SessionView(user: user)
                    .environmentObject(sessionManager)
            }
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured successfully")
            
        } catch {
            print("Error: Could not initialize Amplify", error)
        }
    }
}

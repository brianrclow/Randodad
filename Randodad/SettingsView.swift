//
//  SettingsView.swift
//  Randodad
//
//  Created by Brian Clow on 11/2/20.
//

import Amplify
import SwiftUI



struct SettingsView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    let user: AuthUser

    var body: some View {
        NavigationView {
            VStack {
                Text("Signed in using AWS Amplify as \(user.username)")
                    .font(.largeTitle)
                    .padding(50)
                Spacer()
                Button(action: sessionManager.signOut, label: {
                    HStack {
                        Text("Sign Out")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                }
                )
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(15.0)
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        let userId: String = "1"
        let username: String = "dummy"
    }
    static var previews: some View {
        SettingsView(user: DummyUser())
    }
}

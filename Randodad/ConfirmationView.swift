//
//  ConfirmationView.swift
//  Randodad
//
//  Created by Brian Clow on 11/2/20.
//

import SwiftUI

struct ConfirmationView: View {
    
    @EnvironmentObject var sessionManager: SessionManager

    @State var confirmationCode = ""
    let username: String
    
    var body: some View {
        VStack {
            Text("Username: \(username)")
            TextField("Confirmation Code", text:
                      $confirmationCode)
            Button("Confirm", action: {
                sessionManager.confirm(username: username, code: confirmationCode)
            })
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(username: "brian clow")
    }
}

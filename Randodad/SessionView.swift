//
//  SessionView.swift
//  Randodad
//
//  Created by Brian Clow on 11/2/20.
//

import Amplify
import SwiftUI

struct SessionView: View {
    
    @EnvironmentObject var sessionManager: SessionManager
    
    // Styles Button
    struct GradientButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(Color.white)
                .padding()
                .background(configuration.isPressed ? Color.green : Color.yellow)
                .cornerRadius(15.0)
                .scaleEffect(configuration.isPressed ? 1.3 : 1.0)
        }
    }
    
    // Gets API Key from plist file
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "DadJokeAPI-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'DadJokeAPI-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "x-rapidapi-key") as? String else {
          fatalError("Couldn't find key 'x-rapidapi-key' in 'DadJokeAPI-Info.plist'.")
        }
        return value
      }
    }
    
    let user: AuthUser
    @State private var setup = ""
    @State private var punchline = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("👨🏻")
                    .font(.system(size: 100))
                Spacer()
                Text(setup)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 25))
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
                    .padding(.bottom, 50)
                Text(punchline)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 25))
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
                    
                Spacer()
                Button(action: getJoke, label: {
                    HStack {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        Text("Random Joke")
                    }
                }
                ).buttonStyle(GradientButtonStyle())
                
            }
                .navigationBarTitle("Randodad")
                .navigationBarItems(trailing:
                    NavigationLink(destination: SettingsView(user: user)) {
                        Image(systemName: "gear")
                    }
                )
        }
    }
    
    // Gets new dad joke with API call
    func getJoke() {
        
        // structs of what API Joke response will look like
        struct APIResponse: Codable {
            let body: [Joke]
        }
        struct Joke: Codable {
            let setup: String
            let punchline: String
        }
        
        // url
        let url = URL(string: "https://rapidapi.p.rapidapi.com/random/joke")
        
        guard url != nil else {
            print("Error creating url oject")
            return
        }
        
        // url request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        // specify the header and add apiKey in
        let header = [
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": "dad-jokes.p.rapidapi.com",
            "content-type": "application/json"]
        request.allHTTPHeaderFields = header
        
        // set the request type
        request.httpMethod = "GET"
        
        // get the URL session and create the data task
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in

            guard let data = data, error == nil else{
                return
            }
            
            var result: APIResponse?
            do {
                result = try JSONDecoder().decode(APIResponse.self, from: data)

            } catch {
                print("Error decoding json")
            }

            guard let final = result else {
                return
            }
            
            // set setup and punchline variables with joke dada
            setup = final.body[0].setup
            punchline = final.body[0].punchline
        }
        session.resume()
    }

    struct SessionView_Previews: PreviewProvider {
        // Dummy user so previews work
        private struct DummyUser: AuthUser {
            let userId: String = "1"
            let username: String = "dummy"
        }
        
        static var previews: some View {
            SessionView(user: DummyUser())
        }
    }
}

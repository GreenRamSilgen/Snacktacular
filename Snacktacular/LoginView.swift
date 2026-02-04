//
//  LoginView.swift
//  Snacktacular
//
//  Created by Kiran Shrestha on 2/3/26.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password  = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
            Group {
                TextField("email", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .submitLabel(.next)
                SecureField("password", text: $password)
                    .submitLabel(.done)
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            
            HStack {
                Button("Sign Up") {
                    register()
                }
                .padding(.trailing)
                Button("Log In") {
                    login()
                }
                .padding(.leading)
            }
            .buttonStyle(.borderedProminent)
            .tint(.snack)
            .font(.title2)
            .padding(.top)
        }
        .padding()
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                alertMessage = "😡 SIGNUP ERROR: \(error.localizedDescription)"
                showingAlert = true
                print("😡 SIGNUP ERROR: \(error.localizedDescription)")
            }
            else {
                print("😎 Registration Success")
                //TODO: LOAD LIST VIEW
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                alertMessage = "😡 LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
                print("😡 LOGIN ERROR: \(error.localizedDescription)")
            }
            else {
                print("LOGIN SUCCESS")
                //TODO: Post login
            }
        }
    }
}

#Preview {
    LoginView()
}

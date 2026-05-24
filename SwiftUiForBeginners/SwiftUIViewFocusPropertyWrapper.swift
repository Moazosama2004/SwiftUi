//
//  SwiftUIViewFocusPropertyWrapper.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 24/05/2026.
//

import SwiftUI

struct SwiftUIViewFocusPropertyWrapper: View {
    
    enum LoginFocusedStates {
        case username
        case email
        case password
    }
    
    @FocusState private var selectedFocusedState : LoginFocusedStates?
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack(spacing:20) {
            TextField("username", text: $username)
                .padding()
                .frame(height: 60)
                .background(Color.secondary.opacity(0.3))
                .clipShape(Capsule())
                .keyboardType(.alphabet)
                .disableAutocorrection(true)
                .submitLabel(.next)
                .focused($selectedFocusedState,equals: .username)
                .onSubmit {
                    selectedFocusedState = .email
                }
            
            TextField("email", text: $email)
                .padding()
                .frame(height: 60)
                .background(Color.secondary.opacity(0.3))
                .clipShape(Capsule())
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .submitLabel(.next)
                .focused($selectedFocusedState,equals: .email)
                .onSubmit {
                    selectedFocusedState = .password
                }
            
            
            SecureField("password", text: $password)
                .padding()
                .frame(height: 60)
                .background(Color.secondary.opacity(0.3))
                .clipShape(Capsule())
                .keyboardType(.alphabet)
                .disableAutocorrection(true)
                .submitLabel(.next)
                .focused($selectedFocusedState,equals: .password)
                .onSubmit {
                    print("Login Process....")
                }
        }
        .padding()
        .onAppear {
            selectedFocusedState = .username
        }
    }
}



struct SwiftUIViewFocusPropertyWrapper_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewFocusPropertyWrapper()
    }
}

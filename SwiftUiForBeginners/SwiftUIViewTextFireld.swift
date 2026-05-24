//
//  SwiftUIViewTextFireld.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 24/05/2026.
//

import SwiftUI

struct SwiftUIViewTextFireld: View {
    @State private var username = ""
    @State private var age = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        VStack(spacing:20) {
//            // Platform depandant
//            TextField("Username", text: $username)
//                .textFieldStyle(.automatic)
//
//            TextField("Age", text: $age)
//                .textFieldStyle(.roundedBorder)
//
//            // Same in all Platforms
//            TextField("Email", text: $Phone)
//                .padding()
//
//                .background {
//                    LinearGradient(colors: [.red , .yellow], startPoint: .leading, endPoint: .trailing)
//                }
//                .buttonBorderShape(.roundedRectangle(radius: 16))
                
            
            
            TextField("Username", text: $username)
                .padding()
                .frame(height:60)
                .background {
                    LinearGradient(colors: [.red , .yellow], startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(Capsule())
                .keyboardType(.alphabet)
                .foregroundColor(.white)
         
            
            TextField("Age", text: $age)
                .padding()
                .frame(height:60)
                .background {
                    LinearGradient(colors: [.red , .yellow], startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(Capsule())
                .keyboardType(.numberPad)
                .foregroundColor(.white)
                .onSubmit {
                    print("Age is : \(age)")
                }
            
            
            // Same in all Platforms
            TextField("Email", text: $email)
                .padding()
                .frame(height:60)
                .background {
                    LinearGradient(colors: [.red , .yellow], startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(Capsule())
                .keyboardType(.emailAddress)
                .foregroundColor(.white)
//                .textContentType(.email)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.characters)
                .onSubmit {
                    print("Email is : \(email)")
                }
                
            
            // Same in all Platforms
            TextField("Phone", text: $phone)
                .padding()
                .frame(height:60)
                .background {
                    LinearGradient(colors: [.red , .yellow], startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(Capsule())
                .foregroundColor(.white)
                .keyboardType(.phonePad)
            
            
            TextField("Phone", text: $phone)
                .padding()
                .frame(height:60)
                .background {
                    LinearGradient(colors: [.red , .yellow], startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(Capsule())
                .foregroundColor(.white)
                .keyboardType(.phonePad)
                .disabled(true)
            
            SecureField("Password", text: $password)
                .padding()
                .frame(height:60)
                .background {
                    LinearGradient(colors: [.red , .yellow], startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(Capsule())
                .foregroundColor(.white)
//                .keyboardType(.password)
//                .disabled(true)
            
            
            Spacer()
            
            
        }
        .padding()
    }
}

struct SwiftUIViewTextFireld_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewTextFireld()
    }
}

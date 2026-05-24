//
//  SwiftUIViewOnAppear.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 24/05/2026.
//

import SwiftUI

struct SwiftUIViewOnAppear: View {
    @State private var isLoggedin = false
    @State private var username = ""
    var body: some View {
        VStack(spacing: 40) {
            Text(username)
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .padding()
                .background {
                    LinearGradient(colors: [.blue , .purple], startPoint: .leading, endPoint: .trailing)
                }
                .clipShape(Capsule())
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        username = "Moaz Osama welcome back again."
                    }
                }
            
            Image(systemName: "photo.fill")
                .foregroundColor(.blue)
                .font(.largeTitle)
                .padding()
                .background {
                    Circle()
                        .fill(.white)
                        .shadow(radius: 5)
                }
                .offset(x: isLoggedin ? 100 : -100, y: 0)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isLoggedin)
                .onAppear {
                    isLoggedin = true
                }
        }
            
    }
}

struct SwiftUIViewOnAppear_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewOnAppear()
    }
}

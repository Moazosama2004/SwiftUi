//
//  SwiftUIViewBinding.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 23/05/2026.
//

import SwiftUI

struct SwiftUIViewBinding: View {
    @State private var counter = 0
    
    var backgroundLinearGradient : some View {
        LinearGradient(colors: [.blue , .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    var body: some View {
        ZStack {
            backgroundLinearGradient
            AppCounterFunctionality(counter: $counter)
        }
        .ignoresSafeArea()
        
    }
}

struct SwiftUIViewBinding_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewBinding()
    }
}


struct AppCounterFunctionality : View {
    @Binding var counter : Int
    var body : some View {
        VStack {
            Text(String(counter))
                .foregroundStyle(.white)
                .font(.system(size: 72, weight: .bold, design: .rounded
                             ))
                .padding()
                .background {
                    Circle()
                        .fill(.linearGradient(colors: [.red , .yellow], startPoint: .leading, endPoint: .trailing))
            }
            
            Button {
                counter += 1
            } label: {
                Circle()
                    .fill(.white)
                    .frame(width: 60, height: 60)
                    .shadow(radius: 10)
                    .overlay {
                        Text("+")
                            .font(.title)
                    }
            }
        }
    }
}

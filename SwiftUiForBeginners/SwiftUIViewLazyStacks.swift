//
//  SwiftUIViewLazyStacks.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 24/05/2026.
//

import SwiftUI

struct SwiftUIViewLazyStacks: View {
    var body: some View {
        ScrollView(
            .vertical,
            showsIndicators: false
        ) {
            LazyVStack() {
                ForEach(0..<1000) { index in
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(.blue)
                        .frame(height: 250)
                        .shadow(radius: 5)
                        .overlay {
                            Text("index : \(index)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                        }
                        .onAppear {
                            print("Index : \(index)")
                        }
                }
               
            }
            .padding()
        }
    }
}

struct SwiftUIViewLazyStacks_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewLazyStacks()
    }
}

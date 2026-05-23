//
//  SwiftUIViewStatePropertyWrapper.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 23/05/2026.
//

import SwiftUI

struct SwiftUIViewStatePropertyWrapper: View {
    @State private var counter = 0
    var body: some View {
        VStack(spacing: 20) {
            Text("Counter : \(counter)")
            HStack(spacing: 40) {
                counterButton(label: "-") { counter -= 1 }
                counterButton(label: "+") { counter += 1 }
            }
        }
        
    }
}

private func counterButton(label: String, action: @escaping () -> Void) ->  some View {
    Button(action: action) {
        Circle()
            .fill(.white)
            .frame(width: 50, height: 50)
            .shadow(radius: 1)
            .overlay {
                Text(label)
                    .foregroundStyle(.blue)
            }
    }
}


struct SwiftUIViewStatePropertyWrapper_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewStatePropertyWrapper()
    }
}




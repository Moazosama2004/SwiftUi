//
//  SwiftUICircle.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 17/05/2026.
//

import SwiftUI

struct SwiftUICircle: View {
    var body: some View {
        Circle()
            .trim(from: 0, to:  0.75)
            .stroke(.blue , style: StrokeStyle(lineWidth: 12, lineCap: .round , dash: [50]))
            .background {
                Text("Loading")
                    .font(.title)
                    .fontWeight(.bold)
            }
//            .fill(.blue)
            .foregroundColor(.red)
            .frame(width: 300, height: 300, alignment: .center)
    }
}

struct SwiftUICircle_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUICircle()
    }
}

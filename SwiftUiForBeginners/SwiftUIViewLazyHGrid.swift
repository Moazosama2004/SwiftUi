//
//  SwiftUIViewLazyHGrid.swift
//  SwiftUiForBeginners
//
//  Created by Moaz Osmaa on 26/05/2026.
//

import SwiftUI

struct SwiftUIViewLazyHGrid: View {
    let rows = [
        GridItem(.fixed(80), spacing: nil, alignment: nil),
        GridItem(.fixed(80), spacing: nil, alignment: nil),
        GridItem(.fixed(80), spacing: nil, alignment: nil),
        GridItem(.flexible(minimum: 80, maximum: 160), spacing: nil, alignment: nil)
    ]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows) {
                ForEach(0..<100) { index in
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.linearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 100)
                    
                }
            }
        }
        .padding(.leading)
    }
}

#Preview {
    SwiftUIViewLazyHGrid()
}

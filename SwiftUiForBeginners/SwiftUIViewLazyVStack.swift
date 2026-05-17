//
//  SwiftUIViewLazyHStack.swift
//  SwiftUiForBeginners
//
//  Created by Moaz Osmaa on 26/05/2026.
//

import SwiftUI

struct SwiftUIViewLazyHStack: View {
    let columns : [GridItem] = [
        GridItem(.fixed(100), spacing: nil, alignment: nil),
        GridItem(.fixed(100), spacing: nil, alignment: nil),
        GridItem(.fixed(100), spacing: nil, alignment: nil),
    ]
    
//    let columns = Array(repeating: GridItem(.fixed(100), spacing: nil, alignment: nil), count: 3)
    
//        let columns : [GridItem] = [
//            GridItem(.flexible(), spacing: nil, alignment: nil),
//            GridItem(.flexible(), spacing: nil, alignment: nil),
//            GridItem(.flexible(), spacing: nil, alignment: nil),
//        ]
    
//    let columns : [GridItem] = [
//        GridItem(.adaptive(minimum: 50, maximum: 100), spacing: nil, alignment: nil),
//        GridItem(.adaptive(minimum: 50, maximum: 100), spacing: nil, alignment: nil),
//        GridItem(.adaptive(minimum: 50, maximum: 100), spacing: nil, alignment: nil),
//    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns
                ,pinnedViews: .sectionHeaders
            ) {
                Section {
                    ForEach(1..<32) { index in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.blue)
                            .frame(height: 100)
                            .overlay {
                                Text("\(index)")
                                    .foregroundStyle(.white)
                                    .font(.title)
                                
                            }
                    }
                } header: {
                    Text("Jan")
                        .foregroundStyle(.black)
                        .font(.largeTitle)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.red)
                    
                }
                
                Section {
                    ForEach(1..<32) { index in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.blue)
                            .frame(height: 100)
                            .overlay {
                                Text("\(index)")
                                    .foregroundStyle(.white)
                                    .font(.title)
                                
                            }
                    }
                } header: {
                    Text("Feb")
                        .foregroundStyle(.black)
                        .font(.largeTitle)
                        .frame(height: 100)
                    
                }
                
            }
        }.padding()
    }
}

#Preview {
    SwiftUIViewLazyHStack()
}

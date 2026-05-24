//
//  SwiftUIViewScrollView.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 24/05/2026.
//

import SwiftUI

struct SwiftUIViewScrollView: View {
    @State private var selectedPosition : Int? = nil
    
    var body: some View {
        // VStack - ScrollView[Vertically Behaviour]
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack() {
//                ForEach(0..<10) { index in
//                    RoundedRectangle(cornerRadius: 16)
//                        .fill(.blue)
//                        .padding()
//                        .frame(height: 250)
//                        .overlay {
//                            Text("Index : \(index)")
//                                .font(.title)
//                                .bold()
//                                .foregroundColor(.white)
//                        }
//                }
//            }
//        }
//        .scrollIndicator(.hidden)
        
        
        // HStack - ScrollView[Horizontally Behaviour]
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack() {
//                ForEach(0..<10) { index in
//                    RoundedRectangle(cornerRadius: 16)
//                        .fill(.blue)
//                        .padding()
//                        .frame(width:300 , height: 250)
//                        .shadow(radius: 10)
//                        .overlay {
//                            Text("Index : \(index)")
//                                .font(.title)
//                                .bold()
//                                .foregroundColor(.white)
//                        }
//                }
//            }
//        }
        // ScrollView inside another one
//        ScrollView(
//            [.vertical, .horizontal],
//            showsIndicators: false
//        ) {
//            VStack() {
//                ForEach(0..<10) { _ in
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack() {
//                            ForEach(0..<10) { index in
//                                RoundedRectangle(cornerRadius: 16)
//                                    .fill(.blue)
//                                    .padding()
//                                    .frame(width:300 , height: 250)
//                                    .shadow(radius: 10)
//                                    .overlay {
//                                        Text("Index : \(index)")
//                                            .font(.title)
//                                            .bold()
//                                            .foregroundColor(.white)
//                                    }
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
        
        // Use Scroll Modifiers
        VStack() {
            Button {
                selectedPosition = 5
            } label: {
                Text("ScrollTo")
            }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach(0..<10) { index in
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.blue)
                                .padding()
                                .frame(width:300 , height: 250)
                                .shadow(radius: 10)
                                .overlay {
                                    Text("Index : \(index)")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.white)
                                }
                                .id(index)
                        }
                    }
                }
//                .scrollTargetLayout()
//                .scrollTargetBehaviour(.viewAligned)
//                .scrollPosition(id: , anchor:)
        }
            
        
    }
}

struct SwiftUIViewScrollView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewScrollView()
    }
}

//
//  SwiftUIViewSlider.swift
//  SwiftUiForBeginners
//
//  Created by Moaz Osmaa on 26/05/2026.
//

import SwiftUI

struct SwiftUIViewSlider: View {
    @State private var value = 5.0
    @State private var change = false
    var body: some View {
        VStack {
            
            Text("Value : \(value)")
                .font(.title)
                .bold()
            
            Slider(value: $value)
            
            Slider(value: $value, in: 0...10)
            
            Slider(value: $value, in: 0...10) {
                HStack() {
                    Image(systemName: "figure")
                    Text("Value : \(value)")
                }
            }
            .tint(.red)
            
            
            Slider(value: $value, in: 0...10,step: 1.0)
                
            Slider(value: $value , in: 10...100 , step: 1.0) {
                Text("Value : \(value)")
            } minimumValueLabel: {
                HStack() {
                    Image(systemName: "figure")
                    Text("Min : 10")
                }
            } maximumValueLabel: {
                HStack() {
                    Image(systemName: "figure")
                    Text("Max : 100")
                }
            } onEditingChanged: { valueSliderChanged in
                change = valueSliderChanged
            }
            
            Spacer()
            
            Circle()
                .fill(.red)
                .frame(width: 100 + value , height: 100 + value)
                .opacity(change ? 1.0 : 0.0)

        }
        .padding()
    }
}

#Preview {
    SwiftUIViewSlider()
}

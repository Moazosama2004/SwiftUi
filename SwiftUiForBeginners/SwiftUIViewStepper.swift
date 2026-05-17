//
//  SwiftUIViewStepper.swift
//  SwiftUiForBeginners
//
//  Created by Moaz Osmaa on 26/05/2026.
//

import SwiftUI

struct SwiftUIViewStepper: View {
    @State private var value = 0.0
    var body: some View {
        VStack {
            Stepper("Value: \(value)", value: $value)
                .font(.title)
                .tint(.blue)
//                .tint(Color.red.gradient)
//                .labelsHidden()
//                .fixedSize()
            
            
            Stepper(value: $value) {
                HStack{
                    Image(systemName: "figure")
                    Text("Value: \(value)")
                }
                .font(.title)
                .foregroundStyle(.red)
            }
           
            Stepper("Value : \(value)") {
                value += 3
            } onDecrement: {
                value -= 3
            }

            
            Stepper("Value: \(value)", value: $value,step: 10)
                .font(.title)
                .tint(.blue)
            
            Stepper("Value: \(value)", value: $value,in: 0...5)
                .font(.title)
                .tint(.blue)
            
            Stepper("Value: \(value)", value: $value,in: 0...5 , step: 5)
                .font(.title)
                .tint(.blue)
            
            Circle()
                .fill(.red)
                .frame(width: 100 + value , height: 100 + value)
           
        }
        .padding()
    }
}

#Preview {
    SwiftUIViewStepper()
}

//
//  SwiftUIViewToggle.swift
//  SwiftUiForBeginners
//
//  Created by Moaz Osmaa on 26/05/2026.
//

import SwiftUI

struct SwiftUIViewToggle: View {
    @State private var isOn : Bool = false
    
    var body: some View {
        VStack() {
            Toggle("Notification", isOn: $isOn)
            Text("\(isOn)")
                .font(.title)
            
            
            Toggle("Mic", isOn: $isOn)
                .font(.largeTitle)
                .tint(Color.red.opacity(0.8))
                .foregroundStyle(.green)
            
            Toggle("Mic", isOn: $isOn)
                .font(.largeTitle)
                .tint(Color.red.opacity(0.8))
                .foregroundStyle(.green)
                .toggleStyle(.button)
            
            Toggle("Mic", isOn: $isOn)
                .font(.largeTitle)
                .tint(Color.red.opacity(0.8))
                .foregroundStyle(.green)
                .toggleStyle(.automatic) // platform depandant
            
            Toggle("Mic", systemImage: "mic.fill", isOn: $isOn)
                .font(.largeTitle)
                .foregroundStyle(.green)
                .toggleStyle(.button)
                .labelStyle(.titleAndIcon)
            
            Toggle("Mic", systemImage: isOn ? "mic.fill" : "mic.slash.fill", isOn: $isOn)
                .font(.largeTitle)
                .foregroundStyle(.green)
                .toggleStyle(.button)
                .labelStyle(.iconOnly)
                .contentTransition(.symbolEffect)
                
            
            
            
        }.padding()
        
    }
}

#Preview {
    SwiftUIViewToggle()
}

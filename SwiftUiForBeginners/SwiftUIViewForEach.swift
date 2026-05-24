//
//  SwiftUIViewForEach.swift
//  SwiftUiForBeginners
//
//  Created by Moaz on 24/05/2026.
//

import SwiftUI

struct SwiftUIViewForEach: View {
    let weekDays = [
        "Sat" , "Sun" , "Mon",
        "Thu" , "Wed" , "Tue",
        "Fri"]
    
    let weekDaysStruct : [Day] = [
        Day(name: "Sat"),
        Day(name: "Sun"),
        Day(name: "Mon"),
        Day(name: "Thu"),
        Day(name: "Wed"),
        Day(name: "Tue"),
        Day(name: "Fri")
    ]
    var body: some View {
//        ForEach(0..<10) {index in
//            Text("Moaz Osama")
//                .font(.largeTitle)
//                .bold()
//        }
//
//        ForEach(0..<10) {index in
//            Text("index is : \(index)")
//                .font(.largeTitle)
//                .bold()
//        }
        
//        ForEach(0..<10 , id: \.self) {day in
//            Text("Day : \(day)")
//                .font(.largeTitle)
//                .bold()
//        }
        
//        ForEach(weekDays, id: \.self) {day in
//            Text("Day : \(day)")
//                .font(.largeTitle)
//                .bold()
//        }
        
//        ForEach(0..<weekDays.count, id: \.self) {day in
//            Text("Day : \(day)")
//                .font(.largeTitle)
//                .bold()
//        }
        
        
        ForEach(weekDaysStruct) { day in
            Text("Day : \(day.name)")
                    .font(.largeTitle)
                    .bold()
        }
        
        
        
    }
}

struct Day : Identifiable {
    let id = UUID()
    let name : String
}

struct SwiftUIViewForEach_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViewForEach()
    }
}

//
//  ContentView.swift
//  Fizl
//
//  Created by Dominic on 2023-12-27.
//

import ActivityKit
import SwiftUI

struct ContentView: View {
    @State private var activity: Activity<FizlAttributes>? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            Image("IconSquare")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button("Start Activity") {
                startActivity()
            }
            
            Button("Stop Activity") {
                stopActivity()
            }
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
    
    func startActivity() {
        let attributes = FizlAttributes()
        let state = FizlAttributes.FizlStatus(startTime: Date(), endTime: Date().addingTimeInterval(60), title: "Started at 11:45AM", headline: "Fizl in progress", widgetUrl: "https://google.com")
        
        activity = try? Activity<FizlAttributes>.request(attributes: attributes, content: .init(state: state, staleDate: nil), pushType: nil)
    }
    
    func stopActivity() {
        let state = FizlAttributes.FizlStatus(startTime: .now, endTime: .now, title: "Started at 11:45AM", headline: "Fizl in progress", widgetUrl: "https://google.com")
        
        Task {
            await activity?.end(ActivityContent(state: state, staleDate: nil), dismissalPolicy: .immediate)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}

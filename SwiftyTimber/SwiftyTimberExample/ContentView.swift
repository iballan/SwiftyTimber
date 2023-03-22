//
//  ContentView.swift
//  SwiftyTimberExample
//
//  Created by mbh on 22/3/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 50) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Button {
                logger.i("Button Clicked")
            } label: {
                Text("Click")
            }
            
            
            Button {
                logger.e(MyError(message: "Bugs are not good"), "Error Is Here")
            } label: {
                Text("Error")
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

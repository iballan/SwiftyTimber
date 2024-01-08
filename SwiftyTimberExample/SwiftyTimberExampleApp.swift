//
//  SwiftyTimberExampleApp.swift
//  SwiftyTimberExample
//
//  Created by mbh on 22/3/23.
//

import SwiftUI
import SwiftyTimber

#if DEBUG
// Not necessary to assign Timber to a variable, i just did it for example
let logger = Timber.shared.plant(TimberDebugTree())
#endif
// Here you may plant different tree

@main
struct SwiftyTimberExampleApp: App {
    init() {
        logger.d("Debug message")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

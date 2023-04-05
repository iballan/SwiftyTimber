//
//  MyError.swift
//  SwiftyTimberExample
//
//  Created by mbh on 22/3/23.
//

import Foundation

struct MyError: LocalizedError {
    let message: String
    var errorDescription: String {
        get {
            return message
        }
    }
    var failureReason: String {
        get {
            return message
        }
    }
}

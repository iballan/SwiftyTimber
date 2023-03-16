//
//  TimberTree.swift
//  SwiftyTimber
//
//  Created by mbh on 16/3/23.
//

public protocol TimberTree {
    func print(_ item: Any, level: TimberLogLevel?, filename: String, line: Int, column: Int, funcName: String)
}

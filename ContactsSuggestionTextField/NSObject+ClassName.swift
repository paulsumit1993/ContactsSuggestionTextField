//
//  NSObject+ClassName.swift
//
//  Copyright © 2018 Sumit Paul. All rights reserved.

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

//
//  HexHelper.swift
//  Ripemd160Tests
//
//  Created by pebble8888 on 2020/02/01.
//  Copyright © 2020 pebble8888. All rights reserved.
//

import Foundation

extension UInt32 {
    public func littleEndianHexDescription() -> String {
        return String(format: "%02x%02x%02x%02x",
                      self & 0xff,
                      (self >> 8) & 0xff,
                      (self >> 16) & 0xff,
                      (self >> 24) & 0xff)
    }
}

extension Collection where Iterator.Element == UInt32 {
    public func littleEndianHexDescription() -> String {
        return self.map({ $0.littleEndianHexDescription() }).joined()
    }
}

extension Collection where Iterator.Element == UInt8 {
    public func hexDescription() -> String {
        return self.map({ String(format: "%02x", $0) }).joined()
    }
}

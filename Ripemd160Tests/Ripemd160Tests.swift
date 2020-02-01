//
//  Ripemd160Tests.swift
//  Ripemd160Tests
//
//  Created by pebble8888 on 2020/01/25.
//  Copyright © 2020 pebble8888. All rights reserved.
//

import XCTest
import Ripemd160

class Ripemd160Tests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testLE() {
        let data: [UInt8] = [0x01, 0x02, 0x03, 0x04]
        let result = Ripemd160.fourBytesToLEUInt32(data[data.startIndex..<data.endIndex])
        XCTAssertEqual(result.littleEndianHexDescription(), "01020304")
    }

    func testHash1() {
        let result = Ripemd160.digest([])
        XCTAssertEqual(result.hexDescription(), "9c1185a5c5e9fc54612808977ee8f548b2258d31")
    }

    func testHash2() {
        let s = "a"
        let result = Ripemd160.digest([UInt8](s.utf8))
        XCTAssertEqual(result.hexDescription(), "0bdc9d2d256b3ee9daae347be6f4dc835a467ffe")
    }

    func testHash3() {
        let s = "abc"
        let result = Ripemd160.digest([UInt8](s.utf8))
        XCTAssertEqual(result.hexDescription(), "8eb208f7e05d987a9b044a8e98c6b087f15a0bfc")
    }

    func testHash4() {
        let s = "message digest"
        let result = Ripemd160.digest([UInt8](s.utf8))
        XCTAssertEqual(result.hexDescription(), "5d0689ef49d2fae572b881b123a85ffa21595f36")
    }

    func testHash5() {
        let s = "abcdefghijklmnopqrstuvwxyz"
        let result = Ripemd160.digest([UInt8](s.utf8))
        XCTAssertEqual(result.hexDescription(), "f71c27109c692c1b56bbdceb5b9d2865b3708dbc")
    }

    func testHash6() {
        let s = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
        let result = Ripemd160.digest([UInt8](s.utf8))
        XCTAssertEqual(result.hexDescription(), "12a053384a9c0c88e405a06c27dcf49ada62eb2b")
    }

    func testHash7() {
        let s = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
        let result = Ripemd160.digest([UInt8](s.utf8))
        XCTAssertEqual(result.hexDescription(), "b0e20b6e3116640286ed3a87a5713079b21f5189")
    }

    func testHash8() {
        let b = "1234567890"
        let s = repeatElement(b, count: 8).joined()
        let result = Ripemd160.digest([UInt8](s.utf8))
        XCTAssertEqual(result.hexDescription(), "9b752e45573d4b39f4dbd3323cab82bf63326bfb")
    }

    func testHash9() {
        let md = Ripemd160()
        var x: [UInt32] = [UInt32](repeating: 0x61616161, count: 16)
        for _ in 0..<1000000/64 {
            md.compress(&x)
        }
        let result = md.finish([], 1000000)
        XCTAssertEqual(result.hexDescription(), "52783243c1697bdbe16d37f97f68f08325dc1528")
    }
}

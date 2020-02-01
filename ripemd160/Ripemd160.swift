//
//  Ripemd160.swift
//
//  Copyright © 2020 pebble8888. All rights reserved.
//
// https://homes.esat.kuleuven.be/~bosselae/ripemd160.html
//

import Foundation

open class Ripemd160 {
    private var mdbuf = [UInt32](repeating: 0, count: 5)

    private func rol(_ x: UInt32, _ n: UInt32) -> UInt32 {
        precondition(n < 32, "n < 32)")
        return (x << n) | (x >> (32-n))
    }

    private func f(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
        return x ^ y ^ z
    }

    private func g(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
        return (x & y) | (~x & z)
    }

    private func h(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
        return (x | ~y) ^ z
    }

    private func i(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
        return (x & z) | (y & ~z)
    }

    private func j(_ x: UInt32, _ y: UInt32, _ z: UInt32) -> UInt32 {
        return x ^ (y | ~z)
    }

    private func ff(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= f(b, c, d) &+ x
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func gg(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= g(b, c, d) &+ x &+ 0x5a827999
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func hh(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= h(b, c, d) &+ x &+ 0x6ed9eba1
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func ii(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= i(b, c, d) &+ x &+ 0x8f1bbcdc
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func jj(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= j(b, c, d) &+ x &+ 0xa953fd4e
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func fff(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= f(b, c, d) &+ x
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func ggg(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= g(b, c, d) &+ x &+ 0x7a6d76e9
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func hhh(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= h(b, c, d) &+ x &+ 0x6d703ef3
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func iii(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= i(b, c, d) &+ x &+ 0x5c4dd124
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func jjj(_ a: inout UInt32, _ b: UInt32, _ c: inout UInt32, _ d: UInt32, _ e: UInt32, _ x: UInt32, _ s: UInt32) {
        a &+= j(b, c, d) &+ x &+ 0x50a28be6
        a = rol(a, s) &+ e
        c = rol(c, 10)
    }

    private func setInitialValue() {
        mdbuf[0] = 0x67452301
        mdbuf[1] = 0xefcdab89
        mdbuf[2] = 0x98badcfe
        mdbuf[3] = 0x10325476
        mdbuf[4] = 0xc3d2e1f0
    }

    public init() {
        self.setInitialValue()
    }

    public func compress(_ x: inout [UInt32]) {
        precondition(x.count == 16)

        var aa: UInt32 = mdbuf[0]
        var bb: UInt32 = mdbuf[1]
        var cc: UInt32 = mdbuf[2]
        var dd: UInt32 = mdbuf[3]
        var ee: UInt32 = mdbuf[4]
        var aaa: UInt32 = mdbuf[0]
        var bbb: UInt32 = mdbuf[1]
        var ccc: UInt32 = mdbuf[2]
        var ddd: UInt32 = mdbuf[3]
        var eee: UInt32 = mdbuf[4]

        // round 1
        ff(&aa, bb, &cc, dd, ee, x[ 0], 11)
        ff(&ee, aa, &bb, cc, dd, x[ 1], 14)
        ff(&dd, ee, &aa, bb, cc, x[ 2], 15)
        ff(&cc, dd, &ee, aa, bb, x[ 3], 12)
        ff(&bb, cc, &dd, ee, aa, x[ 4], 5)
        ff(&aa, bb, &cc, dd, ee, x[ 5], 8)
        ff(&ee, aa, &bb, cc, dd, x[ 6], 7)
        ff(&dd, ee, &aa, bb, cc, x[ 7], 9)
        ff(&cc, dd, &ee, aa, bb, x[ 8], 11)
        ff(&bb, cc, &dd, ee, aa, x[ 9], 13)
        ff(&aa, bb, &cc, dd, ee, x[10], 14)
        ff(&ee, aa, &bb, cc, dd, x[11], 15)
        ff(&dd, ee, &aa, bb, cc, x[12], 6)
        ff(&cc, dd, &ee, aa, bb, x[13], 7)
        ff(&bb, cc, &dd, ee, aa, x[14], 9)
        ff(&aa, bb, &cc, dd, ee, x[15], 8)

        // round 2
        gg(&ee, aa, &bb, cc, dd, x[ 7], 7)
        gg(&dd, ee, &aa, bb, cc, x[ 4], 6)
        gg(&cc, dd, &ee, aa, bb, x[13], 8)
        gg(&bb, cc, &dd, ee, aa, x[ 1], 13)
        gg(&aa, bb, &cc, dd, ee, x[10], 11)
        gg(&ee, aa, &bb, cc, dd, x[ 6], 9)
        gg(&dd, ee, &aa, bb, cc, x[15], 7)
        gg(&cc, dd, &ee, aa, bb, x[ 3], 15)
        gg(&bb, cc, &dd, ee, aa, x[12], 7)
        gg(&aa, bb, &cc, dd, ee, x[ 0], 12)
        gg(&ee, aa, &bb, cc, dd, x[ 9], 15)
        gg(&dd, ee, &aa, bb, cc, x[ 5], 9)
        gg(&cc, dd, &ee, aa, bb, x[ 2], 11)
        gg(&bb, cc, &dd, ee, aa, x[14], 7)
        gg(&aa, bb, &cc, dd, ee, x[11], 13)
        gg(&ee, aa, &bb, cc, dd, x[ 8], 12)

        // round 3
        hh(&dd, ee, &aa, bb, cc, x[ 3], 11)
        hh(&cc, dd, &ee, aa, bb, x[10], 13)
        hh(&bb, cc, &dd, ee, aa, x[14], 6)
        hh(&aa, bb, &cc, dd, ee, x[ 4], 7)
        hh(&ee, aa, &bb, cc, dd, x[ 9], 14)
        hh(&dd, ee, &aa, bb, cc, x[15], 9)
        hh(&cc, dd, &ee, aa, bb, x[ 8], 13)
        hh(&bb, cc, &dd, ee, aa, x[ 1], 15)
        hh(&aa, bb, &cc, dd, ee, x[ 2], 14)
        hh(&ee, aa, &bb, cc, dd, x[ 7], 8)
        hh(&dd, ee, &aa, bb, cc, x[ 0], 13)
        hh(&cc, dd, &ee, aa, bb, x[ 6], 6)
        hh(&bb, cc, &dd, ee, aa, x[13], 5)
        hh(&aa, bb, &cc, dd, ee, x[11], 12)
        hh(&ee, aa, &bb, cc, dd, x[ 5], 7)
        hh(&dd, ee, &aa, bb, cc, x[12], 5)

        // round 4
        ii(&cc, dd, &ee, aa, bb, x[ 1], 11)
        ii(&bb, cc, &dd, ee, aa, x[ 9], 12)
        ii(&aa, bb, &cc, dd, ee, x[11], 14)
        ii(&ee, aa, &bb, cc, dd, x[10], 15)
        ii(&dd, ee, &aa, bb, cc, x[ 0], 14)
        ii(&cc, dd, &ee, aa, bb, x[ 8], 15)
        ii(&bb, cc, &dd, ee, aa, x[12], 9)
        ii(&aa, bb, &cc, dd, ee, x[ 4], 8)
        ii(&ee, aa, &bb, cc, dd, x[13], 9)
        ii(&dd, ee, &aa, bb, cc, x[ 3], 14)
        ii(&cc, dd, &ee, aa, bb, x[ 7], 5)
        ii(&bb, cc, &dd, ee, aa, x[15], 6)
        ii(&aa, bb, &cc, dd, ee, x[14], 8)
        ii(&ee, aa, &bb, cc, dd, x[ 5], 6)
        ii(&dd, ee, &aa, bb, cc, x[ 6], 5)
        ii(&cc, dd, &ee, aa, bb, x[ 2], 12)

        // round 5
        jj(&bb, cc, &dd, ee, aa, x[ 4], 9)
        jj(&aa, bb, &cc, dd, ee, x[ 0], 15)
        jj(&ee, aa, &bb, cc, dd, x[ 5], 5)
        jj(&dd, ee, &aa, bb, cc, x[ 9], 11)
        jj(&cc, dd, &ee, aa, bb, x[ 7], 6)
        jj(&bb, cc, &dd, ee, aa, x[12], 8)
        jj(&aa, bb, &cc, dd, ee, x[ 2], 13)
        jj(&ee, aa, &bb, cc, dd, x[10], 12)
        jj(&dd, ee, &aa, bb, cc, x[14], 5)
        jj(&cc, dd, &ee, aa, bb, x[ 1], 12)
        jj(&bb, cc, &dd, ee, aa, x[ 3], 13)
        jj(&aa, bb, &cc, dd, ee, x[ 8], 14)
        jj(&ee, aa, &bb, cc, dd, x[11], 11)
        jj(&dd, ee, &aa, bb, cc, x[ 6], 8)
        jj(&cc, dd, &ee, aa, bb, x[15], 5)
        jj(&bb, cc, &dd, ee, aa, x[13], 6)

        // parallel round 1
        jjj(&aaa, bbb, &ccc, ddd, eee, x[ 5], 8)
        jjj(&eee, aaa, &bbb, ccc, ddd, x[14], 9)
        jjj(&ddd, eee, &aaa, bbb, ccc, x[ 7], 9)
        jjj(&ccc, ddd, &eee, aaa, bbb, x[ 0], 11)
        jjj(&bbb, ccc, &ddd, eee, aaa, x[ 9], 13)
        jjj(&aaa, bbb, &ccc, ddd, eee, x[ 2], 15)
        jjj(&eee, aaa, &bbb, ccc, ddd, x[11], 15)
        jjj(&ddd, eee, &aaa, bbb, ccc, x[ 4], 5)
        jjj(&ccc, ddd, &eee, aaa, bbb, x[13], 7)
        jjj(&bbb, ccc, &ddd, eee, aaa, x[ 6], 7)
        jjj(&aaa, bbb, &ccc, ddd, eee, x[15], 8)
        jjj(&eee, aaa, &bbb, ccc, ddd, x[ 8], 11)
        jjj(&ddd, eee, &aaa, bbb, ccc, x[ 1], 14)
        jjj(&ccc, ddd, &eee, aaa, bbb, x[10], 14)
        jjj(&bbb, ccc, &ddd, eee, aaa, x[ 3], 12)
        jjj(&aaa, bbb, &ccc, ddd, eee, x[12], 6)

        // parallel round 2
        iii(&eee, aaa, &bbb, ccc, ddd, x[ 6], 9)
        iii(&ddd, eee, &aaa, bbb, ccc, x[11], 13)
        iii(&ccc, ddd, &eee, aaa, bbb, x[ 3], 15)
        iii(&bbb, ccc, &ddd, eee, aaa, x[ 7], 7)
        iii(&aaa, bbb, &ccc, ddd, eee, x[ 0], 12)
        iii(&eee, aaa, &bbb, ccc, ddd, x[13], 8)
        iii(&ddd, eee, &aaa, bbb, ccc, x[ 5], 9)
        iii(&ccc, ddd, &eee, aaa, bbb, x[10], 11)
        iii(&bbb, ccc, &ddd, eee, aaa, x[14], 7)
        iii(&aaa, bbb, &ccc, ddd, eee, x[15], 7)
        iii(&eee, aaa, &bbb, ccc, ddd, x[ 8], 12)
        iii(&ddd, eee, &aaa, bbb, ccc, x[12], 7)
        iii(&ccc, ddd, &eee, aaa, bbb, x[ 4], 6)
        iii(&bbb, ccc, &ddd, eee, aaa, x[ 9], 15)
        iii(&aaa, bbb, &ccc, ddd, eee, x[ 1], 13)
        iii(&eee, aaa, &bbb, ccc, ddd, x[ 2], 11)

        // parallel round 3
        hhh(&ddd, eee, &aaa, bbb, ccc, x[15], 9)
        hhh(&ccc, ddd, &eee, aaa, bbb, x[ 5], 7)
        hhh(&bbb, ccc, &ddd, eee, aaa, x[ 1], 15)
        hhh(&aaa, bbb, &ccc, ddd, eee, x[ 3], 11)
        hhh(&eee, aaa, &bbb, ccc, ddd, x[ 7], 8)
        hhh(&ddd, eee, &aaa, bbb, ccc, x[14], 6)
        hhh(&ccc, ddd, &eee, aaa, bbb, x[ 6], 6)
        hhh(&bbb, ccc, &ddd, eee, aaa, x[ 9], 14)
        hhh(&aaa, bbb, &ccc, ddd, eee, x[11], 12)
        hhh(&eee, aaa, &bbb, ccc, ddd, x[ 8], 13)
        hhh(&ddd, eee, &aaa, bbb, ccc, x[12], 5)
        hhh(&ccc, ddd, &eee, aaa, bbb, x[ 2], 14)
        hhh(&bbb, ccc, &ddd, eee, aaa, x[10], 13)
        hhh(&aaa, bbb, &ccc, ddd, eee, x[ 0], 13)
        hhh(&eee, aaa, &bbb, ccc, ddd, x[ 4], 7)
        hhh(&ddd, eee, &aaa, bbb, ccc, x[13], 5)

        // parallel round 4
        ggg(&ccc, ddd, &eee, aaa, bbb, x[ 8], 15)
        ggg(&bbb, ccc, &ddd, eee, aaa, x[ 6], 5)
        ggg(&aaa, bbb, &ccc, ddd, eee, x[ 4], 8)
        ggg(&eee, aaa, &bbb, ccc, ddd, x[ 1], 11)
        ggg(&ddd, eee, &aaa, bbb, ccc, x[ 3], 14)
        ggg(&ccc, ddd, &eee, aaa, bbb, x[11], 14)
        ggg(&bbb, ccc, &ddd, eee, aaa, x[15], 6)
        ggg(&aaa, bbb, &ccc, ddd, eee, x[ 0], 14)
        ggg(&eee, aaa, &bbb, ccc, ddd, x[ 5], 6)
        ggg(&ddd, eee, &aaa, bbb, ccc, x[12], 9)
        ggg(&ccc, ddd, &eee, aaa, bbb, x[ 2], 12)
        ggg(&bbb, ccc, &ddd, eee, aaa, x[13], 9)
        ggg(&aaa, bbb, &ccc, ddd, eee, x[ 9], 12)
        ggg(&eee, aaa, &bbb, ccc, ddd, x[ 7], 5)
        ggg(&ddd, eee, &aaa, bbb, ccc, x[10], 15)
        ggg(&ccc, ddd, &eee, aaa, bbb, x[14], 8)

        // parallel round 5
        fff(&bbb, ccc, &ddd, eee, aaa, x[12], 8)
        fff(&aaa, bbb, &ccc, ddd, eee, x[15], 5)
        fff(&eee, aaa, &bbb, ccc, ddd, x[10], 12)
        fff(&ddd, eee, &aaa, bbb, ccc, x[ 4], 9)
        fff(&ccc, ddd, &eee, aaa, bbb, x[ 1], 12)
        fff(&bbb, ccc, &ddd, eee, aaa, x[ 5], 5)
        fff(&aaa, bbb, &ccc, ddd, eee, x[ 8], 14)
        fff(&eee, aaa, &bbb, ccc, ddd, x[ 7], 6)
        fff(&ddd, eee, &aaa, bbb, ccc, x[ 6], 8)
        fff(&ccc, ddd, &eee, aaa, bbb, x[ 2], 13)
        fff(&bbb, ccc, &ddd, eee, aaa, x[13], 6)
        fff(&aaa, bbb, &ccc, ddd, eee, x[14], 5)
        fff(&eee, aaa, &bbb, ccc, ddd, x[ 0], 15)
        fff(&ddd, eee, &aaa, bbb, ccc, x[ 3], 13)
        fff(&ccc, ddd, &eee, aaa, bbb, x[ 9], 11)
        fff(&bbb, ccc, &ddd, eee, aaa, x[11], 11)

        // combine results
        // final result for mdbuf[0]
        ddd &+= cc &+ mdbuf[1]
        mdbuf[1] = mdbuf[2] &+ dd &+ eee
        mdbuf[2] = mdbuf[3] &+ ee &+ aaa
        mdbuf[3] = mdbuf[4] &+ aa &+ bbb
        mdbuf[4] = mdbuf[0] &+ bb &+ ccc
        mdbuf[0] = ddd
    }

    public func finish(_ data: [UInt8], _ length: Int) -> [UInt8] {
        precondition(data.count < 64)

        let datalen: UInt32 = length > 0 ? UInt32(length & 0xffffffff) : 0
        let mswlen: UInt32 = length > 0 ? UInt32(length >> 64) : 0

        var x: [UInt32] = [UInt32](repeating: 0, count: 16)
        for i in 0 ..< Int(datalen & 63) {
            x[i>>2] ^= UInt32(data[i]) << (8 * (i&3))
        }
        x[Int((datalen>>2) & 15)] ^= (1 << (8 * (datalen&3) + 7))

        if (datalen & 63) > 55 {
            compress(&x)
            for i in 0 ..< 16 {
                x[i] = 0
            }
        }
        x[14] = datalen << 3
        x[15] = (datalen >> 29) | (mswlen << 3)
        compress(&x)

        var hashcode: [UInt8] = [UInt8](repeating: 0, count: 20)
        for i in stride(from: 0, to: 20, by: 4) {
            hashcode[i] = UInt8(mdbuf[i>>2] & 0xff)
            hashcode[i+1] = UInt8((mdbuf[i>>2] >> 8) & 0xff)
            hashcode[i+2] = UInt8((mdbuf[i>>2] >> 16) & 0xff)
            hashcode[i+3] = UInt8((mdbuf[i>>2] >> 24) & 0xff)
        }
        setInitialValue()
        return hashcode
    }

    public static func fourBytesToLEUInt32(_ data: Slice<[UInt8]>) -> UInt32 {
        var val: UInt32 = 0
        val += UInt32(data[data.startIndex])
        val += UInt32(data[data.startIndex + 1]) << 8
        val += UInt32(data[data.startIndex + 2]) << 16
        val += UInt32(data[data.startIndex + 3]) << 24
        return val
    }

    /// calculate digest
    public static func digest(_ data: [UInt8]) -> [UInt8] {
        let md = Ripemd160()
        let length: Int = data.count
        var x = [UInt32](repeating: 0, count: 16)
        var remain: Int = data.count
        var index = data.startIndex
        while remain > 63 {
            for i in 0..<16 {
                let slice: Slice<[UInt8]> = data[index..<index.advanced(by: 4)]
                x[i] = fourBytesToLEUInt32(slice)
                index = index.advanced(by: 4)
            }
            md.compress(&x)
            remain -= 64
        }
        return md.finish(Array(data[index..<data.endIndex]), length)
    }
}

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

//
//  ed25519.swift
//  Ed25519
//
//  Created by luca3104 on 2018/02/11.
//  Copyright © 2018 luca3104. All rights reserved.
//

import Foundation

public struct Ed25519 {
    
    public static func keypair () -> (pub:String, pri:String) {
        let keypair = generate_keypair()
        let pub = base64FromBytes(keypair.pk)
        let pri = base64FromBytes(keypair.sk)
        return (pub, pri)
    }
    
    public static func sign(_ msg:String, _ pri: String, _ pub: String) -> String {
        var sig: [UInt8] = Array(repeating: 0, count: 64)
        let msgArr: [UInt8] = Array(msg.utf8)
        let priArr: [UInt8] = base64ToBytes(pri)
        let pubArr: [UInt8] = base64ToBytes(pub)
        var skpk: [UInt8] = Array(repeating: 0, count: 64)
        for i in 0..<32 {
            skpk[i] = priArr[i]
        }
        for i in 0..<32 {
            skpk[32+i] = pubArr[i]
        }
        generate_sign(&sig, msgArr, skpk)
        return base64FromBytes(sig)
    }
    
    public static func verify(_ sig:String, _ msg:String, _ pub:String) -> Bool {
        let sigArr: [UInt8] = base64ToBytes(sig)
        let msgArr: [UInt8] = Array(msg.utf8)
        let pubArr: [UInt8] = base64ToBytes(pub)
        return open(sigArr, msgArr, pubArr)
    }
    
    private static func base64FromBytes (_ arr: [UInt8]) -> String {
        let hexstr = arr.toHexString()
        let data = Data(hex: hexstr)
        return data.base64EncodedString()
    }
    
    private static func base64ToBytes (_ str: String) -> [UInt8] {
        let data = Data(base64Encoded: str, options: [])!
        return data.bytes
    }
}


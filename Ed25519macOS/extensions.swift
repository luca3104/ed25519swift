//
//  extensions.swift
//  BigInt
//
//  Created by luca3104 on 2018/02/11.
//  Copyright © 2018 luca3104. All rights reserved.
//

import Foundation

extension UnicodeScalar {
    var hexNibble:UInt8 {
        let value = self.value
        if 48 <= value && value <= 57 {
            return UInt8(value - 48)
        }
        else if 65 <= value && value <= 70 {
            return UInt8(value - 55)
        }
        else if 97 <= value && value <= 102 {
            return UInt8(value - 87)
        }
        fatalError("\(self) not a legal hex nibble")
    }
    
    var revertHexNibble:UInt8 {
        let value = self.value
        if 48 <= value && value <= 57 {
            return UInt8(value + 48)
        }
        else if 65 <= value && value <= 70 {
            return UInt8(value + 55)
        }
        else if 97 <= value && value <= 102 {
            return UInt8(value + 87)
        }
        fatalError("\(self) not a legal hex nibble")
    }
}

extension Data {
    init(hex:String) {
        let scalars = hex.unicodeScalars
        var bytes = Array<UInt8>(repeating: 0, count: (scalars.count + 1) >> 1)
        for (index, scalar) in scalars.enumerated() {
            var nibble = scalar.hexNibble
            if index & 1 == 0 {
                nibble <<= 4
            }
            bytes[index >> 1] |= nibble
        }
        self = Data(bytes: bytes)
    }
}




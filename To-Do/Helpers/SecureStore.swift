//
//  Encryption.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 20/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//

import CryptoSwift

let encryptionKey:String = "A_SIXTEEN_CHARACTER_STRING";
let encryptionIV:String = "A_SIXTEEN_CHARACTER_STRING";

public func encryptString() {
    let test = "hi there, good sir."
    let encryptedTest:String = try! test.aesEncrypt(key: encryptionKey, iv: encryptionIV)
    print("Test : ", test)
    print("Encrypted Test : ", encryptedTest)
}

public func dencryptString() {
    let encyrptedTest = "9aEFhS7kox7PMi2HHlEnC6f/KxFyC2LGnD+gDvSRzlg=iWBEZWzdsrtxJXBQ6YX9Ug=="
    let dencryptedTest:String = try! test.aesDecrypt(key: encryptionKey, iv: encryptionIV)
    print("Encrypted Test : ", encyrptedTest )
    print("Decrypted Test : ", dencryptedTest)
}


extension String{
    
    func aesEncrypt(key: String, iv: String) throws -> String {
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: Array(key.utf8), blockMode: CBC.init(iv: Array(iv.utf8)), padding: .pkcs7).encrypt([UInt8](data));
//        let encrypted = try! AES(key: key, blockMode: .CBC, padding: .pkcs7) //AES(key: key, iv: iv, blockMode: .CBC, padding: .pkcs7).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self)!
        let decrypted = try! AES(key: Array(key.utf8), blockMode: CBC.init(iv: Array(iv.utf8)), padding: .pkcs7).decrypt([UInt8](data));
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
        
    }
}

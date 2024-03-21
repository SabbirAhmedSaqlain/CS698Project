//
//  Encryption.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 20/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//

import CryptoSwift

class SecureStore {
    
    static  func EncryptedString(originalString: String) -> String{
        
        let key = "yourpasswordd123" // Must be 16, 24, or 32 bytes long
        let iv = "drowssapdrowssap" // Must be 16 bytes long
        
        do {
            // Convert string to data
            let data = originalString.data(using: .utf8)!
            
            // Encrypt
            let encryptedData = try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7).encrypt(data.bytes)
            let encryptedString = encryptedData.toBase64()
            print("Encrypted string: \(encryptedString )")
            return encryptedString
            
        } catch {
            print("Encryption/Decryption error: \(error)")
        }
        
        return ""
    }
    
    
    static  func DecryptedString(encryptedString: String) -> String{
        // let originalString = "Hello, world!"
        let key = "yourpasswordd123" // Must be 16, 24, or 32 bytes long
        let iv = "drowssapdrowssap" // Must be 16 bytes long
        
        // Decrypt
        if let encryptedData = Data(base64Encoded: encryptedString), let decryptedData = try? AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7).decrypt(encryptedData.bytes) {
            let decryptedString = String(data: Data(decryptedData), encoding: .utf8)
            print("Decrypted string: \(decryptedString ?? "Decryption failed")")
            
            return decryptedString ?? ""
        }
        
        
        return ""
    }
    
    
    
}



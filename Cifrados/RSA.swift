import Foundation

struct Llaves {
    static let publica: String = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvMTkuxHyGBCgswgfb8WiwhCHxcTeK/m/lRbyQ68Wg8OI/AEdsRrD1JfQQyruylQk6iH9mFXswMbSvAvDbFqguvpoMH8nLErjGX55fVIrGDBo3o4wU+4avxDcA626wWhuNNvs/GvBFQze0IOirLK+2C44PiBN1vvyIBLuMiQED2bWhdCYCBZBCfKfYcrzsbHAGsFdvQ2zNdlNIIK6izzaXCJRB48a0z9FImna3iZbHgg5XeniGtStCgR03YSDSJpfNy4XkzxBpvOHGU159pHh/oaSs0aOpuLvAY64mh4o6oNuzVUzvKzSIRCr37GrdPUzIpIjyzn4sTqMxh4/QRwFBwIDAQAB"

    static let privada: String = "MIIEpAIBAAKCAQEAvMTkuxHyGBCgswgfb8WiwhCHxcTeK/m/lRbyQ68Wg8OI/AEdsRrD1JfQQyruylQk6iH9mFXswMbSvAvDbFqguvpoMH8nLErjGX55fVIrGDBo3o4wU+4avxDcA626wWhuNNvs/GvBFQze0IOirLK+2C44PiBN1vvyIBLuMiQED2bWhdCYCBZBCfKfYcrzsbHAGsFdvQ2zNdlNIIK6izzaXCJRB48a0z9FImna3iZbHgg5XeniGtStCgR03YSDSJpfNy4XkzxBpvOHGU159pHh/oaSs0aOpuLvAY64mh4o6oNuzVUzvKzSIRCr37GrdPUzIpIjyzn4sTqMxh4/QRwFBwIDAQABAoIBABWpAhX1GTJptgbVB8ZrhyF9hBbNYDDrl3AkEehyTsMPzMgd2KpZx969DMioRH4y6Yl0HQU91szIA6ZQMzxbqdXKpenqrTQH48cpHAelRgyggWgIKMN4rtj9tkE1zhgjQ4INOkQ8mQsxTt/eOuxWFk/3/bwjOMtSXZYQlgRq3YxmrbJKo2DYd094URe3D0wHXY1wC/vlvA4pMlbmRqI54j631lWF9o7B5w2jv8nLNt8akjxSyeclZ8Zkr/RoZWrlJKWeTmPQGSrOQYT31Ynn90XYvWhgoXO+QNJyFwdNv/Kj0CarnJwy+Ae5OuFYIsc95Or7V1eYmHlxf0wBiL/fxAECgYEA9frgw+prQqWRxLh0Z3aYEZ673h4ScKHnQbRwX0nMUJekHe/NPlMasYwoMSI06/G20dXpbMLmmgu2I+63rmOlgaJ2HzBEBXEHbPy+r0ev5f3IsnY2fIHSPOoyvt3JG4NJ8C07W1uyf/jPlxNYsTICn3piR44WymiXKU3yscEY5ZECgYEAxHVpGXGwtSJ8EaxUIV5HG81Cugo5oKzSb6Pha05+jDK4TvYc9Nm6KnqnmxyFkJeSLQQEmpaXgbTk+gTZBlkooDXX+FCAghpvfsSLte0Psouih/ZSL/QN0R1Aa0ESWrwRF95WvOD9/V4ifY/JCp+FOgbz3cXavGBDxZjSm50ilRcCgYEA4P3Voz4DWBWrrH1vc8eFNvCzNGrbQQzGQ1IxSudsq/bYVc2nNS+8hdQGW1LHh10zdOGtvh7T4Ol/c4SBnFBm7ZlVZBe40CVfvm+8VwVCPiOQ9LOuCNqSG8e4HN8ueSzwb3BgD6NjNSy3bJ90i7eLsKW3yW2NKRzbzxsON0rBZBECgYBJpBEvXnR0kWacYVJv550UCM74WZjcZ6vB+VYoGRZKi0CXKJ4WEf88qRlmhTxzxL0gbp8jK0vDbQFfzq1jOcyGsWgxRkvFeQ9OH3KXUTNPJBRajrSkEQGU3zgkfBHbPR/TKJ6u0k+ix8R5+InNl5oi9DQ5b07cyeDdkrlvZ2ltJQKBgQCTOjP6Kal5JbWAgqX4SRBmXMVjPSJNu1+qcb0naMm+ueE2SuuAhX0yKbn/5VvH4qfK7rwvRnJnba/BRioS8g95paieYs7+0amD3uj6F0ItbaDLlzsXgIJAFyKoa816a9ZwAWbjGghqJuQvmIf1XXkrH3H3hjvUAVsKTa3y0k9YnA=="
}

class RSA {
    
    public func encrypt(strText: String, llavePublica: String) -> String {
        var strReturn = ""
        var errorPublicKey: Unmanaged<CFError>? = nil
        
        guard let dataPublicKey = Data(base64Encoded: llavePublica) else { return "" }
        
        var attributesPublicKey: CFDictionary {
            return [kSecAttrKeyType         : kSecAttrKeyTypeRSA,
                    kSecAttrKeyClass        : kSecAttrKeyClassPublic,
                    kSecAttrKeySizeInBits   : 2048,
                    kSecReturnPersistentRef : kCFBooleanTrue as Any] as CFDictionary
        }
        guard let secKeyPublicKey = SecKeyCreateWithData(dataPublicKey as CFData, attributesPublicKey, &errorPublicKey) else {
            print(errorPublicKey.debugDescription)
            return ""
        }

        var error:Unmanaged<CFError>? = nil
        let plainData = strText.data(using: .utf8)
        if let encryptedMessageData:Data = SecKeyCreateEncryptedData(secKeyPublicKey, .rsaEncryptionPKCS1, plainData! as CFData, &error) as Data?{
            strReturn = encryptedMessageData.base64EncodedString()
        } else {
            print("Error encrypting")
            return ""
        }
        return strReturn
    }

    public func decrypt(strText: String?, llavePrivada: String) -> String? {
        var strReturn = ""
        guard let strText = strText else{
            return strReturn
        }

        let keyData = Data(base64Encoded: llavePrivada)!
        let key = SecKeyCreateWithData(keyData as NSData, [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
            kSecAttrKeySizeInBits   : 2048,
            kSecReturnPersistentRef : kCFBooleanTrue as Any
        ] as CFDictionary, nil)
        
        guard let privateKey = key else{
            print("error private key:::::::")
            return ""
        }
        
        let dataEncr : Data =  Data(base64Encoded: strText)!

        var error : Unmanaged<CFError>?
        if let decryptedMessage:Data = SecKeyCreateDecryptedData(privateKey, .rsaEncryptionPKCS1, dataEncr as CFData, &error) as Data?{
            strReturn = String.init(data: decryptedMessage, encoding: .utf8)!
        } else {
            print("Error decrypting: \(error.debugDescription)")
        }
        return strReturn
    }
    
}

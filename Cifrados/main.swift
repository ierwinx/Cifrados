import Foundation

let texto = "Hola :)"

func hexa() -> Void {
    print("Hexadecimal")
    let hexadecimal = Hexadecimal()
    guard let res1: String = hexadecimal.stringToHex(texto) else { return }
    print(res1)
    
    guard let res2: String = hexadecimal.hexToString(res1) else { return }
    print(res2)
}

func base64() -> Void {
    print("Base64")
    let base64 = Base64()
    guard let res1: String = base64.stringToBase64(texto) else { return }
    print(res1)
    
    guard let res2: String = base64.base64ToString(res1) else { return }
    print(res2)
}

func rsa() -> Void {
    print("RSA")
    let rsa = RSA()
    let res1: String = rsa.encrypt(strText: texto, llavePublica: Llaves.publica)
    print(res1)
    
    guard let res2: String = rsa.decrypt(strText: res1, llavePrivada: Llaves.privada) else { return }
    print(res2)
}

func aes() -> Void {
    print("AES256")
    
    do {
        let password = "foo"
        let salt = AES256.randomSalt()
        let iv = AES256.randomIv()
        let key = try AES256.createKey(password: password.data(using: .utf8)!, salt: salt)
        let aes = try AES256(key: key, iv: iv)
        
        let encrypted = try aes.encrypt(texto.data(using: .utf8)!)
        print(String(decoding: encrypted, as: UTF8.self))
        let decrypted = try aes.decrypt(encrypted)
        print(String(decoding: decrypted, as: UTF8.self))
    } catch {
        print(error.localizedDescription)
    }
   
}


hexa()
print()
base64()
print()
rsa()
print()
aes()

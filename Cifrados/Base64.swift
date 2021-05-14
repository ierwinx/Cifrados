import Foundation

class Base64 {
    
    public func stringToBase64(_ string : String) -> String? {
        var data = Data(string.utf8)
        data = data.base64EncodedData()
        return String(data: data, encoding: .utf8)
    }

    private func base64ToData(_ string : String) -> Data? {
        Data.init(base64Encoded: string, options: .ignoreUnknownCharacters)
    }

    public func base64ToString(_ strB64 : String) -> String? {
        guard let data = base64ToData(strB64) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
}

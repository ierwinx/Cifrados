import Foundation

class Hexadecimal {

    public func stringToHex(_ string : String) -> String? {
        let data = Data(string.utf8)
        let hex =  data.map{ String(format:"%02x", $0) }.joined()
        return hex
    }

    public func hexToString(_ text: String) -> String? {
        do{
            let regex = try NSRegularExpression(pattern: "(0x)?([0-9A-Fa-f]{2})", options: .caseInsensitive)
            let textNS = text as NSString
            let matchesArray = regex.matches(in: textNS as String, options: [], range: NSMakeRange(0, textNS.length))
            let characters = matchesArray.map {
                Character(UnicodeScalar(UInt32(textNS.substring(with: $0.range(at: 2)), radix: 16)!)!)
            }
            return String(characters)
        }catch _ as NSError{
            return nil
        }
    }

}

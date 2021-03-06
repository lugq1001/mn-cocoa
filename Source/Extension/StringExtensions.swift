//
//  StringExtensions.swift
//  MNCocoa
//
//  Created by 陆广庆 on 2018/1/14.
//  Copyright © 2018年 陆广庆. All rights reserved.
//

#if os(OSX)
    import Cocoa
#elseif os(iOS)
    import UIKit
    import SwiftSoup
#endif
import CryptoSwift

public extension String {

    var intValue: Int? {
        return Int(self)
    }
    
    var b64Encode: String {
        return Data(self.utf8).base64EncodedString()
    }

    var b64Decode: String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    var md5: String {
        return self.md5()
    }

    var isEmail: Bool {
        let regEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: self)
    }

    var urlEncoded: String {
        if let escapedString = self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return escapedString
        }
        return self
    }
    
    var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http"
    }
    
    var isValidHttpsUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "https"
    }
 
    var cgFloatValue: CGFloat {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        return CGFloat(n.floatValue)
    }
    
    var pathExtension: String {
        return (self as NSString).pathExtension
    }
    
    var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
 
    func appendingPathComponent(_ str: String) -> String {
        return (self as NSString).appendingPathComponent(str)
    }
    
    var firstCharacterAsString: String? {
        guard let first = self.first else { return nil }
        return String(first)
    }
    
    var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }
    
    var fileMD5: String {
        #if os(OSX)
        return self
        #elseif os(iOS)
        return YZYMD5().digestHexFromFile(self)
        #endif
    }
    
    #if os(iOS)
    var html2AttributedString: String? {
        do {
            let doc: Document = try SwiftSoup.parse(self)
            return try doc.text()
        } catch Exception.Error(_, _) {
            return nil
        } catch {
            return nil
        }
    }
    
    var html2String: String {
        return html2AttributedString ?? ""
    }
    #endif
    
}

//
//  String.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 10.07.2023..
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}

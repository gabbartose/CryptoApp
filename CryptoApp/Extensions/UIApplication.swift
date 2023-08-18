//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 05.07.2023..
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Gabrijel Bartosek on 06.07.2023..
//

import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}

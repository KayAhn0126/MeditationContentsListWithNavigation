//
//  Meditation.swift
//  MeditationContentsList
//
//  Created by Kay on 2022/08/28.
//

import Foundation

struct Meditation: Hashable {
    let title: String
    let description: String
    let imageName: String
}

extension Meditation {
    static let list: [Meditation] = [
        Meditation(title: "Kessonga's Guide to Focus", description: "Gain a mindful approach to focus and attention.", imageName: "sun.max.fill"),
        Meditation(title: "Quick Focus Resets", description: "Short exercises for getting back into focus", imageName: "sparkles"),
        Meditation(title: "Focus music", description: "Find and keep focus with music from world-renowned artists. Get in the zone with techno trailblazer Monika Kruse.", imageName: "cloud.rain.fill"),
        Meditation(title: "Soundscapes", description: "3D recording from the world's loveliest places", imageName: "cloud.sun.rain.fill"),
        Meditation(title: "For Work", description: "Build and regain focus for a productive workday.", imageName: "thermometer.snowflake"),
        Meditation(title: "For Study", description: "Overcome distraction and stat on topic.", imageName: "snowflake"),
        Meditation(title: "For Movement", description: "Boost your performance with mindfulness. Manage emotions and expections while rehabilitating", imageName: "thermometer.sun.fill"),
    ]
    
    static let recommendations: [Meditation] = [
        Meditation(title: "Kessonga's Guide to Focus", description: "Gain a mindful approach to focus and attention.", imageName: "sun.max.fill"),
        Meditation(title: "For Work", description: "Build and regain focus for a productive workday.", imageName: "thermometer.snowflake"),
        Meditation(title: "For Movement", description: "Boost your performance with mindfulness. Manage emotions and expections while rehabilitating", imageName: "thermometer.sun.fill"),
    ]
}

//
//  Color+Extension.swift
//
//  Thank you @brunowernimont
//  https://twitter.com/brunowernimont
//  http://brunowernimont.me/howtos/make-swiftui-color-codable
//  Created by 1amageek on 2022/03/13.
//

import Foundation
import CoreGraphics
@_exported import SwiftUI

#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

fileprivate extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif

    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        if let convertedColor = SystemColor(self).usingColorSpace(.sRGB) {
            convertedColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        }
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif

        return (r, g, b, a)
    }
}

fileprivate extension Color {
    
    /// https://developer.apple.com/design/human-interface-guidelines/foundations/color/#system-colors
    static func from(name: String) -> Color? {
        switch name {
            case "red": return Color.red
            case "orange": return Color.orange
            case "yellow": return Color.yellow
            case "green": return Color.green
            case "mint": return Color.mint
            case "teal": return Color.teal
            case "cyan": return Color.cyan
            case "blue": return Color.blue
            case "indigo": return Color.indigo
            case "purple": return Color.purple
            case "pink": return Color.pink
            case "brown": return Color.brown
            case "white": return Color.white
            case "gray": return Color.gray
            case "black": return Color.black
            case "clear": return Color.clear
            case "primary": return Color.primary
            case "secondary": return Color.secondary
            default: return nil
        }
    }
    
    var name: String? {
        switch self {
            case Color.red: return "red"
            case Color.orange: return "orange"
            case Color.yellow: return "yellow"
            case Color.green: return "green"
            case Color.mint: return "mint"
            case Color.teal: return "teal"
            case Color.cyan: return "cyan"
            case Color.blue: return "blue"
            case Color.indigo: return "indigo"
            case Color.purple: return "purple"
            case Color.pink: return "pink"
            case Color.brown: return "brown"
            case Color.white: return "white"
            case Color.gray: return "gray"
            case Color.black: return "black"
            case Color.clear: return "clear"
            case Color.primary: return "primary"
            case Color.secondary: return "secondary"
            default: return nil
        }
    }
}

extension Color: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name, red, green, blue, alpha
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let name = try container.decode(String?.self, forKey: .name) {
            guard let color = Self.from(name: name) else {
                throw EncodingError.invalidValue(name, EncodingError.Context(codingPath: [CodingKeys.name], debugDescription: "Invalid color name."))
            }
            self = color
        } else {
            let r = try container.decode(Double.self, forKey: .red)
            let g = try container.decode(Double.self, forKey: .green)
            let b = try container.decode(Double.self, forKey: .blue)
            let a = try container.decode(Double.self, forKey: .alpha)
            self.init(SystemColor(red: r, green: g, blue: b, alpha: a))
        }
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else { return }
        let name = self.name
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
        try container.encode(colorComponents.alpha, forKey: .alpha)
    }
}

//
//  RGB.swift
//
//
//  Created by nori on 2022/03/13.
//

import Foundation
import CoreGraphics
import SwiftUI

public struct RGB: Codable, Hashable {

    public var r: CGFloat
    public var g: CGFloat
    public var b: CGFloat
    public var a: CGFloat

    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) {
        self.r = red
        self.g = green
        self.b = blue
        self.a = alpha
    }
}

extension RGB {

#if os(iOS)
    public typealias PlatformColor = UIColor
#else
    public typealias PlatformColor = NSColor
#endif

    public var platformColor: PlatformColor { PlatformColor(red: r, green: g, blue: b, alpha: a) }

    public static var red: RGB { PlatformColor.systemRed.rgb }
    public static var green: RGB { PlatformColor.systemGreen.rgb }
    public static var blue: RGB { PlatformColor.systemBlue.rgb }
    public static var orange: RGB { PlatformColor.systemOrange.rgb }
    public static var yellow: RGB { PlatformColor.systemYellow.rgb }
    public static var pink: RGB { PlatformColor.systemPink.rgb }
    public static var purple: RGB { PlatformColor.systemPurple.rgb }
    public static var teal: RGB { PlatformColor.systemTeal.rgb }
    public static var indigo: RGB { PlatformColor.systemIndigo.rgb }
    public static var brown: RGB { PlatformColor.systemBrown.rgb }
    public static var mint: RGB { PlatformColor.systemMint.rgb }
    public static var cyan: RGB { PlatformColor.systemCyan.rgb }

    public static var label: RGB {
#if os(iOS)
        UIColor.label.rgb
#else
        NSColor.labelColor.rgb
#endif
    }

    public static var secondary: RGB {
#if os(iOS)
        UIColor.secondaryLabel.rgb
#else
        NSColor.secondaryLabelColor.rgb
#endif
    }

    public static var tertiary: RGB {
#if os(iOS)
        UIColor.tertiaryLabel.rgb
#else
        NSColor.tertiaryLabelColor.rgb
#endif
    }

    public static var quaternary: RGB {
#if os(iOS)
        UIColor.quaternaryLabel.rgb
#else
        NSColor.quaternaryLabelColor.rgb
#endif
    }

    public static var link: RGB {
#if os(iOS)
        UIColor.link.rgb
#else
        NSColor.linkColor.rgb
#endif
    }

    public static var placeholder: RGB {
#if os(iOS)
        UIColor.placeholderText.rgb
#else
        NSColor.placeholderTextColor.rgb
#endif
    }
}

#if os(iOS)
import UIKit

extension RGB {
    public var color: Color { Color(UIColor(red: r, green: g, blue: b, alpha: a)) }
}

extension Color {
    public init(_ rgb: RGB) {
        self.init(uiColor: rgb.platformColor)
    }
}


extension UIColor {
    public var rgb: RGB {
        let components = self.cgColor.components!
        return RGB(red: components[0], green: components[1], blue: components[2], alpha: components[3])
    }
}

#endif

#if os(macOS)
import AppKit

extension RGB {
    public var color: Color { Color(nsColor: NSColor(red: r, green: g, blue: b, alpha: a)) }
}

extension Color {
    public init(_ rgb: RGB) {
        self.init(rgb.platformColor)
    }
}

extension NSColor {
    public var rgb: RGB {
        let components = self.cgColor.components!
        return RGB(red: components[0], green: components[1], blue: components[2], alpha: components[3])
    }
}

#endif

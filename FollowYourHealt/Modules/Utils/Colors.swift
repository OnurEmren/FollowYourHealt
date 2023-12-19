//
//  Colors.swift
//  FollowYourHealt
//
//  Created by Onur Emren on 13.12.2023.
//

import Foundation
import UIKit

enum Colors {
    static let colors: [UIColor] = [
        UIColor(red: 0.98, green: 0.96, blue: 0.86, alpha: 1),
        UIColor(red: 0.97, green: 0.82, blue: 0.63, alpha: 1),
        UIColor(red: 0.99, green: 0.90, blue: 0.83, alpha: 1),
        UIColor(red: 0.99, green: 0.94, blue: 0.78, alpha: 1),
        UIColor(red: 0.97, green: 0.89, blue: 0.88, alpha: 1)
    ]
    
    static let lightBluePalette: [UIColor] = [
        UIColor(red: 0.78, green: 0.96, blue: 1.0, alpha: 1),
        UIColor(red: 0.67, green: 0.89, blue: 1.0, alpha: 1),
        UIColor(red: 0.83, green: 0.94, blue: 1.0, alpha: 1),
        UIColor(red: 0.87, green: 0.96, blue: 1.0, alpha: 1),
        UIColor(red: 0.79, green: 0.92, blue: 1.0, alpha: 1)
    ]
    
    static let red: CGFloat = 227.0 / 255.0
    static let green: CGFloat = 242.0 / 255.0
    static let blue: CGFloat = 247.0 / 255.0
    
    static let darkRed: CGFloat = 190.0 / 190.0
    static let darkGreen: CGFloat = 200.0 / 200.0
    static let darkBlue: CGFloat = 260.0 / 260.0
    
    static let appMainColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    static let pickerViewColor = UIColor(red: darkRed, green: darkGreen, blue: darkBlue, alpha: 1)
    
    static let cellsColor = UIColor(red: 0.98, green: 0.96, blue: 0.86, alpha: 1)
    static let color3 = UIColor(red: 0.99, green: 0.90, blue: 0.83, alpha: 1)
    static let color4 = UIColor(red: 0.99, green: 0.94, blue: 0.78, alpha: 1)
}

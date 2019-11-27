//
//  Sentiment.swift
//  NLPDemo
//
//  Created by Mars Geldard on 12/6/19.
//  Copyright © 2019 Mars Geldard. All rights reserved.
//

import UIKit

enum Sentiment: String, CustomStringConvertible {

    case positive = "Positive"
    case negative = "Negative"
    case neutral = "None"

    
    var description: String { return self.rawValue }
    
    var icon: String {
        switch self {
            case .positive: return "😄"
            case .negative: return "😢"
            default: return "😐"
        }
    }

    var color: UIColor {
        switch self {
            case .positive: return UIColor.systemGreen
            case .negative: return UIColor.systemRed
            default: return UIColor.systemGray
        }
    }

    init(rawValue: String) {
        // initialising RawValues must match class labels in training files
        switch rawValue {
            case "Pos": self = .positive
            case "Neg": self = .negative
            default: self = .neutral
        }
    }

}

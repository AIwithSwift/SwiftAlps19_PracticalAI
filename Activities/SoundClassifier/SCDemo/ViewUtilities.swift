//
//  ViewUtilities.swift
//  SCDemo
//
//  Created by Mars Geldard on 27/11/19.
//  Copyright © 2019 Mars Geldard. All rights reserved.
//

import UIKit

extension ViewController {
    
    private func summonAlertView(message: String? = nil) {
        let alertController = UIAlertController(
            title: "Error",
            message: message ?? "Action could not be completed.",
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(alertController, animated: true)
    }
}

class ThreeStateButton: UIButton {
    
    enum ButtonState {
        case enabled(title: String, color: UIColor)
        case inProgress(title: String, color: UIColor)
        case disabled(title: String, color: UIColor)
    }
    
    func changeState(to state: ThreeStateButton.ButtonState) {
        switch state {
            case .enabled(let title, let color):
                self.setTitle(title, for: .normal)
                self.backgroundColor = color
                self.isEnabled = true
            
            case .inProgress(let title, let color):
                self.setTitle(title, for: .normal)
                self.backgroundColor = color
                self.isEnabled = true

            case .disabled(let title, let color):
                self.setTitle(title, for: .disabled)
                self.backgroundColor = color
                self.isEnabled = false
        }
    }
}

class AnimalCell: UICollectionViewCell {
    static let identifier = "AnimalCollectionViewCell"
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var textLabel: UILabel!
}

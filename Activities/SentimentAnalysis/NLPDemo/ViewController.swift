//
//  ViewController.swift
//  NLPDemo
//
//  Created by Mars Geldard on 12/6/19.
//  Copyright © 2019 Mars Geldard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emojiView: UILabel!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func analyseSentimentButtonPressed(_ sender: Any) { performSentimentAnalysis() }
    
    private let placeholderText = "Type something here..."

    // TODO: store object capable of classifying text
    
    override func viewDidLoad() {
        textView.text = placeholderText
        textView.textColor = UIColor.lightGray
        textView.delegate = self
        
        super.viewDidLoad()
    }
    
    private func performSentimentAnalysis() {

        var sentimentClass = Sentiment.neutral
        
        if let text = textView.text {
            // TODO: do something with the text
        }
        
        emojiView.text = sentimentClass.icon
        labelView.text = sentimentClass.description
        colorView.backgroundColor = sentimentClass.color
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
}


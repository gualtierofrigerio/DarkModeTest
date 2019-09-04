//
//  ViewController.swift
//  DarkModeTest
//
//  Created by Gualtiero Frigerio on 04/09/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var longTextLabel: UILabel!
    var settingsManager:SettingsManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let text = "very long string forcing the system to wrap it to multiple lines"
        let attributedString = NSMutableAttributedString(string: text)
        let wholeRange = text.startIndex..<text.endIndex
        attributedString.addAttribute(.foregroundColor, value:UIColor.label, range: NSRange(wholeRange, in:text))
        longTextLabel.attributedText = attributedString
        
        settingsManager = SettingsManager(withDelegate: self)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        print("traitCollectionDidChange: isDark = \(isDarkMode)")
    }
}

extension ViewController: SettingsManagerDelegate {
    func updateTheme(newTheme: Theme) {
        print("updated theme!")
        switch newTheme {
        case .Dark:
            overrideUserInterfaceStyle = .dark
        case .Light:
            overrideUserInterfaceStyle = .light
        case .System:
            overrideUserInterfaceStyle = .unspecified
        }
    }
}

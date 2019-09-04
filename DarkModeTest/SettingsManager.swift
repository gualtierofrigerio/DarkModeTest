//
//  SettingsManager.swift
//  DarkModeTest
//
//  Created by Gualtiero Frigerio on 04/09/2019.
//  Copyright © 2019 Gualtiero Frigerio. All rights reserved.
//

import Foundation

enum Theme:Int {
    case Light      = 0
    case Dark       = 1
    case System     = 2
}

protocol SettingsManagerDelegate {
    func updateTheme(newTheme:Theme)
}

class SettingsManager {
    
    var delegate:SettingsManagerDelegate?
    
    init(withDelegate delegate:SettingsManagerDelegate) {
        self.delegate = delegate
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
        
        NotificationCenter.default.addObserver(self, selector: #selector( self.defaultsChanged), name: UserDefaults.didChangeNotification, object: nil)

    }
    
    func getCurrentTheme() -> Theme {
        let defaults = UserDefaults.standard
        let themeInt = defaults.integer(forKey: "theme")
        print("themeInt = \(themeInt)")
        return Theme(rawValue: themeInt) ?? Theme.System
    }
}

extension SettingsManager {
    @objc private func defaultsChanged(notification:NSNotification) {
        delegate?.updateTheme(newTheme: getCurrentTheme())
    }
}

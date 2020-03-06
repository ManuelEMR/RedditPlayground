//
//  Storyboarded.swift
//  RedditApp
//
//  Created by Manuel Munoz on 06/03/2020.
//  Copyright © 2020 Manuel Munoz. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate(storyboardName: String) -> Self
    static func instantiate(storyboard: Storyboard) -> Self
}

extension UIViewController: Storyboarded {
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate(storyboard: Storyboard) -> Self {
        instantiate(storyboardName: storyboard.rawValue)
    }
    
    // ViewControllers created by storyboard
    static func instantiate(storyboardName: String) -> Self {
        // Pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        
        // Splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]
        
        // Load our storyboard
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        
        // Instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self // swiftlint:disable:this force_cast
    }
}

enum Storyboard: String {
    case auth = "Auth"
    case main = "Main"
}

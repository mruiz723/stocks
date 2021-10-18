//
//  Storyboarded.swift
//  Stocks
//
//  Created by Marlon David Ruiz Arroyave on 15/10/21.
//

import Foundation
import UIKit

public protocol Storyboarded {
    static var storyboardName: String { get }
    static func instantiate(bundle: Bundle?) -> Self
}

extension Storyboarded where Self: UIViewController {
    /**
        Create a ViewController according to the identifier
        - Parameter bundle: The bundle where storyboard is located
        - Returns: A ViewController
     */
    static func instantiate(bundle: Bundle? = nil) -> Self {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(identifier: identifier)
    }

    /// Get the storyboardName from describing self and dropLast ViewController word
    static var storyboardName: String {
        let describingString = String(describing: self)
        return String(describingString.dropLast("ViewController".count))
    }
}

//
//  StoryboardIdentifiable.swift
//  SampleAppUsingViper
//
//  Created by Daniyal Yousuf on 2023-04-30.
//

import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

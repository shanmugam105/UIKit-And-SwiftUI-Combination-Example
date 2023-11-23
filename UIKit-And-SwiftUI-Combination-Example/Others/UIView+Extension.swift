//
//  UIView+Extension.swift
//  UIKit-And-SwiftUI-Combination-Example
//
//  Created by Sparkout on 23/11/23.
//

import UIKit

// MARK: - Insert constrained subview
extension UIView {
    func embed(childViewController: UIViewController) {
        self.addSubview(childViewController.view)
        constrainViewEqual(holderView: self, view: childViewController.view)
    }
    
    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
}


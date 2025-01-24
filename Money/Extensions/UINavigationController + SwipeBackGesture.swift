//
//  UINavigationController + SwipeBackGesture.swift
//  Money
//
//  Created by Iacob Zanoci on 24/01/2025.
//

import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

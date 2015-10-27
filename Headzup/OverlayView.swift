//
//  OverlayView.swift
//  Headzup
//
//  Created by Sandeep Menon Ayyappankutty on 10/27/15.
//  Copyright © 2015 Inflexxion. All rights reserved.
//

import Foundation
import UIKit

public class OverlayView {

    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()

    class var shared: OverlayView {
        struct Static {
            static let instance: OverlayView = OverlayView()
        }
        return Static.instance
    }

    public func showOverlay(view: UIView!) {
        overlayView = UIView(frame: UIScreen.mainScreen().bounds)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        activityIndicator.center = overlayView.center
        overlayView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        view.addSubview(overlayView)
    }

    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
}
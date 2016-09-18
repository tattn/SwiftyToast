//
//  SwiftyToast.swift
//  SwiftyToast
//
// Copyright (c) 2016 Tatsuya Tanaka
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE

import UIKit

open class SwiftyToast: UIView {

    public enum Position: Int {
        case middle = 1
        case top = 2
        case bottom = 4
        case left = 8
        case right = 16
    }

    open class SwiftyToastConfig: NSObject {
        // Appearance
        open var maxWidth = CGFloat(0.8)
        open var paddingHorizontal = CGFloat(10.0)
        open var paddingVertical = CGFloat(10.0)
        open var cornerRadius = CGFloat(8)
        open var alpha = CGFloat(0.9)
        open var font = UIFont(name: "HiraKakuProN-W6", size: 15.0)
        open var textColor = UIColor.white
        open var backgroundColor = UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1.0)

        // Shadow
        open var shadow = false
        open var shadowOpacity = Float(0.8)
        open var shadowRadius = CGFloat(5.0)
        open var shadowOffset = CGSize(width: 4.0, height: 4.0)
        open var shadowColor = UIColor.gray.cgColor

        // Duration
        open var durationBefore = 1.0
        open var duration = 1.3
        open var durationAfter = 1.0

        // Position
        open var position = Position.middle.rawValue


        func duplicate() -> SwiftyToastConfig {
            let newInstance = SwiftyToastConfig()
            newInstance.maxWidth = config.maxWidth
            newInstance.paddingHorizontal = config.paddingHorizontal
            newInstance.paddingVertical = config.paddingVertical
            newInstance.cornerRadius = config.cornerRadius
            newInstance.alpha = config.alpha
            newInstance.font = config.font
            newInstance.textColor = config.textColor
            newInstance.backgroundColor = config.backgroundColor

            newInstance.shadow = config.shadow
            newInstance.shadowOpacity = config.shadowOpacity
            newInstance.shadowRadius = config.shadowRadius
            newInstance.shadowOffset = config.shadowOffset
            newInstance.shadowColor = config.shadowColor

            newInstance.durationBefore = config.durationBefore
            newInstance.duration = config.duration
            newInstance.durationAfter = config.durationAfter

            newInstance.position = config.position
            return newInstance
        }
    }

    static var config = SwiftyToastConfig()
    fileprivate var _config = config.duplicate()

    fileprivate func setup(_ message: String, parent: UIView) {
        self.backgroundColor = _config.backgroundColor
        self.alpha = _config.alpha
        self.clipsToBounds = true
        self.layer.cornerRadius = _config.cornerRadius
        if _config.shadow {
            self.layer.masksToBounds = false
            self.layer.shadowOpacity = _config.shadowOpacity
            self.layer.shadowRadius = _config.shadowRadius
            self.layer.shadowOffset = _config.shadowOffset
            self.layer.shadowColor = _config.shadowColor
        }

        let rect = parent.frame
        let msgLabel = UILabel(frame: CGRect(x: 0, y: 0, width: rect.width * _config.maxWidth, height: rect.height))
        msgLabel.text = message
        msgLabel.textColor = _config.textColor
        msgLabel.font = _config.font
        msgLabel.numberOfLines = 0
        msgLabel.sizeToFit()
        self.addSubview(msgLabel)

        let size = CGSize(  width: msgLabel.frame.width + _config.paddingHorizontal * 2,
                                height: msgLabel.frame.height + _config.paddingVertical * 2)
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        self.center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        if _config.position & Position.top.rawValue != 0 {
            self.frame.origin.y = 0
        } else if _config.position & Position.bottom.rawValue != 0 {
            self.frame.origin.y = rect.height - self.frame.height
        }
        if _config.position & Position.left.rawValue != 0 {
            self.frame.origin.x = 0
        } else if (_config.position & Position.right.rawValue != 0) {
            self.frame.origin.x = rect.width - self.frame.width
        }

        msgLabel.center = parent.convert(self.center, to: self)
    }

// MARK: - shows

    open class func show(_ message: String) {
        self.show(message, view: topView())
    }

    open class func show(_ message: String, view: UIView) {
        show(message, view:view, config: { _ in })
    }

    open class func show(_ message: String, config: (SwiftyToastConfig) -> Void) {
        show(message, view: topView(), config: config)
    }

    open class func show(_ message: String, view: UIView, config: (SwiftyToastConfig) -> Void) {
        for subview in view.subviews {
            if subview is SwiftyToast {
                subview.removeFromSuperview()
            }
        }

        let toast = SwiftyToast()
        config(toast._config)
        view.addSubview(toast)
        view.bringSubview(toFront: toast)
        toast.setup(message, parent: view)

        toast.fadeInOut()
    }

    fileprivate class func topView() -> UIView {
        var window = UIApplication.shared.keyWindow
        if (window == nil) {
            window = UIApplication.shared.windows[0]
        }
        var viewController = window?.rootViewController
        while (viewController!.presentedViewController != nil) {
            viewController = viewController!.presentedViewController
        }
        return viewController!.view
    }

// MARK: - animations

    fileprivate func fadeInOut() {
        self.alpha = 0
        UIView.animate(withDuration: _config.durationBefore, animations: { () -> Void in
            self.alpha = 1.0
        }, completion: { (finished) -> Void in
            UIView.animate(withDuration: self._config.durationAfter, delay: self._config.duration,
                options: UIViewAnimationOptions.curveLinear, animations: { () -> Void in
                self.alpha = 0
            }, completion: { (finished) -> Void in
                self.removeFromSuperview()
            })
        }) 
    }
}

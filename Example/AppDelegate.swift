//
//  AppDelegate.swift
//  Example
//
//  Created by Tanaka Tatsuya on 2016/06/05.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var counter = 0
    var view: UIView?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        let VC = UIViewController()
        view = VC.view
        view?.backgroundColor = UIColor.whiteColor()

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = VC

        let button = UIButton(type: UIButtonType.System)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 60)
        button.setTitle("Button", forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(AppDelegate.touchUpButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        VC.view.addSubview(button)
        button.center = window!.center
        button.frame.offsetInPlace(dx: 0, dy: -60)
        return true
    }

    @IBAction func touchUpButton(sender: UIButton) {
        if counter == 0 {
            SwiftyToast.show("Hello world")
        } else if counter == 1 {
            SwiftyToast.show("Hello world\nToast test", view:view!) { config in
                // appearance
                config.maxWidth = CGFloat(0.8)
                config.paddingHorizontal = CGFloat(10.0)
                config.paddingVertical = CGFloat(10.0)
                config.cornerRadius = CGFloat(8)
                config.alpha = CGFloat(0.5)
                config.font = UIFont(name: "SnellRoundhand", size: 25.0)
                config.textColor = UIColor(red: 0.192, green: 0.216, blue: 0.082, alpha: 1.0)
                config.backgroundColor = UIColor(red: 0.886, green: 0.976, blue: 0.72, alpha: 1.0)
                // shadow
                config.shadow = true
                config.shadowOpacity = Float(0.5)
                config.shadowRadius = CGFloat(10.0)
                config.shadowOffset = CGSize(width: 4.0, height: 4.0)
                config.shadowColor = UIColor(red: 0.576, green: 0.624, blue: 0.36, alpha: 1.0).CGColor
                // duration
                config.durationBefore = 1.0
                config.duration = 2.0
                config.durationAfter = 0.5
                // position
                config.position = SwiftyToast.Position.Bottom.rawValue | SwiftyToast.Position.Right.rawValue
            }
        }

        counter = (counter + 1) % 2
    }
}

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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        let VC = UIViewController()
        view = VC.view
        view?.backgroundColor = .white

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = VC
        window?.makeKeyAndVisible()

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 60)
        button.setTitle("Button", for: .normal)
        button.addTarget(self, action: #selector(touchUpButton), for: .touchUpInside)

        VC.view.addSubview(button)
        button.center = window!.center
        button.frame.origin.y -= 60
        return true
    }

    @IBAction func touchUpButton(sender: UIButton) {
        if counter == 0 {
            SwiftyToast.show("Hello world")
        } else if counter == 1 {
            SwiftyToast.show("Hello world\nToast test", view:view!) { config in
                // appearance
                config.maxWidth = 0.8
                config.paddingHorizontal = 10.0
                config.paddingVertical = 10.0
                config.cornerRadius = 8
                config.alpha = 0.5
                config.font = UIFont(name: "SnellRoundhand", size: 25.0)
                config.textColor = UIColor(red: 0.192, green: 0.216, blue: 0.082, alpha: 1.0)
                config.backgroundColor = UIColor(red: 0.886, green: 0.976, blue: 0.72, alpha: 1.0)
                // shadow
                config.shadow = true
                config.shadowOpacity = 0.5
                config.shadowRadius = 10.0
                config.shadowOffset = CGSize(width: 4.0, height: 4.0)
                config.shadowColor = UIColor(red: 0.576, green: 0.624, blue: 0.36, alpha: 1.0).cgColor
                // duration
                config.durationBefore = 1.0
                config.duration = 2.0
                config.durationAfter = 0.5
                // position
                config.position = SwiftyToast.Position.bottom.rawValue | SwiftyToast.Position.right.rawValue
            }
        }

        counter = (counter + 1) % 2
    }
}

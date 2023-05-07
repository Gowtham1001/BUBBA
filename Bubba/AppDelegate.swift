//
//  AppDelegate.swift
//  Bubba
//
//  Created by Shrreya Ram on 21/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var splashView: UIImageView?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//
//        splashView = UIImageView(frame: UIScreen.main.bounds)
//        splashView?.image = UIImage(named: "BUBBA_LOGO_V1 1.png")
//
//        // Add the splash view to the window and bring it to the front
//        window?.addSubview(splashView!)
//        window?.bringSubviewToFront(splashView!)
//        // Animate the splash view
//        UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseInOut, animations: {
//            self.splashView?.alpha = 0.0
//            self.splashView?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//        }) { (finished) in
//            self.splashView?.removeFromSuperview()
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}


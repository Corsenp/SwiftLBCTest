//
//  AppDelegate.swift
//  PierreTestLBC
//
//  Created by Pierre Corsenac on 07/03/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainVC = MainViewController()
        let mainNC = MainNavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .orange
        window?.rootViewController = mainNC
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0.93, green: 0.46, blue: 0.20, alpha: 1.00)]
        mainNC.navigationBar.titleTextAttributes = textAttributes
        
        mainVC.title = "Le Bon Coin"
        mainNC.viewControllers = [mainVC]
        
        return true
    }

}


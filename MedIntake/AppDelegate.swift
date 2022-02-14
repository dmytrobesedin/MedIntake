//
//  AppDelegate.swift
//  MedIntake
//
//  Created by Дмитрий Беседин on 13.05.2019.
//  Copyright © 2019 DmytroBesedin. All rights reserved.
//

import UIKit
import Firebase
import  UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      FirebaseApp.configure()
        
        let theme = Theme()
        theme.applyTheme()
       
// test searchPillList
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//
//        let mainVC = SearchPillViewController()
//        window?.rootViewController = mainVC
//
//        window?.makeKeyAndVisible()
//
//
//
        
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if error != nil {
                print(error?.localizedDescription )
            }
        }
        center.delegate  = self
     
        // when you did't auth
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
             //   self.showModalAuth()

            }
            

        }
        return true
    }
    

  func showModalAuth()  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let newVC = storyboard.instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController else {return}
        self.window?.rootViewController?.present(newVC, animated: true, completion: nil)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound, .badge])
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


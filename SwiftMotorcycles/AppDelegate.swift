//
//  AppDelegate.swift
//  SwiftMotorcycles
//
//  Created by Jonas Frid on 2019-02-27.
//  Copyright © 2019 Jonas Frid. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.registerDependencies()
        self.injectDependencies()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let swinjectStoryboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: self.container)
        window.rootViewController = swinjectStoryboard.instantiateInitialViewController()

        return true
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

    private func registerDependencies() {
        self.container.register(WebServiceProtocol.self, factory: { resolver in
            return WebService()
        }) //.inObjectScope(.container)
        
        self.container.register(MotorcyclesViewModelProtocol.self, factory: { resolver in
            return MotorcyclesViewModel(webService: resolver.resolve(WebServiceProtocol.self))
        })
        
        self.container.register(EditMotorcycleViewModelProtocol.self, factory: { resolver in
            return EditMotorcycleViewModel(webService: resolver.resolve(WebServiceProtocol.self))
        })
    }
    
    private func injectDependencies() {
        self.container.storyboardInitCompleted(MotorcyclesViewController.self) { (resolver, viewController) in
            viewController.viewModel = resolver.resolve(MotorcyclesViewModelProtocol.self)
        }
        
        self.container.storyboardInitCompleted(MotorcycleViewController.self) { (resolver, viewController) in
            viewController.viewModel = resolver.resolve(EditMotorcycleViewModelProtocol.self)
        }
    }
}

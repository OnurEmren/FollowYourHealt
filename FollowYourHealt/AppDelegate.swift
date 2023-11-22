//
//  AppDelegate.swift
//  FollowYourHealt
//
//  Created by Onur Emren on 22.11.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyLessonsModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Core Data Context
    lazy var managedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()

}


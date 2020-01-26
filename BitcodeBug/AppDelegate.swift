//
//  Created by Zsombor Szabo on 26/01/2020.
//  Copyright © 2020 IZE. All rights reserved.
//

import UIKit
import Combine
import BitcodeBugSwiftPackage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var model = Model()
    var cancellable: AnyCancellable?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.cancellable = model.publisher(for: \.counter).sink { (value) in
            print("Counter changed: \(value)")
        }
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
            guard let self = self else { return }
            self.model.counter += 1
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


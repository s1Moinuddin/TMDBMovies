//
//  AppDelegate.swift
//  TMDBMovies
//
//  Created by S.M.Moinuddin on 6/3/25.
//

import UIKit
import SVProgressHUD

func DLog<T>(_ object: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    #if DEBUG
    let fileString = file as NSString
    let fileLastPathComponent = fileString.lastPathComponent as NSString
    let filename = fileLastPathComponent.deletingPathExtension
    print("\(filename).\(function)[\(line)]: \(object)\n", terminator: "")
    #endif
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    private func setupProgressHud() {
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            SVProgressHUD.setMinimumDismissTimeInterval(0.3)
        }

}


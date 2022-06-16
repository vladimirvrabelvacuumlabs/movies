//
//  MoviesApp.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import SwiftUI

@main
struct MoviesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MoviesScreen(viewModel: MoviesScreenViewModel(moviesRepository: DIContainer.shared.moviesRepository), diContainer: DIContainer.shared)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        true
    }
}

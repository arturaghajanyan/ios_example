//
//  SceneDelegate.swift
//  Armnature
//
//  Created by Arthur on 5/26/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var ref: DatabaseReference!

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.showModalAuth()
            } else {
                self.getCurrentUserData(user: user)
                self.showHomePage()
            }
        }
    }

    private func getCurrentUserData(user: User?) {
        self.ref = Database.database().reference()
        self.ref.child("users").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
        let value = snapshot.value as? NSDictionary
            UserData.setCurrentUser(user: UserData(email: value?["email"] as? String ?? "", password: value?["password"] as? String ?? "", firstName: value?["firstName"] as? String ?? "", lastName: value?["lastName"] as? String ?? "", city: value?["city"] as? String ?? ""))
            self.showHomePage()

        }) { (error) in
          print(error.localizedDescription)
        }
    }
    
    private func showModalAuth() {
        let mainStoryboard = UIStoryboard(name: "Signin", bundle: Bundle.main)
        guard let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SigninViewController") as? SigninViewController else { return }
        viewController.viewModel = SigninViewModel(data: SignDataBuilder.createSignInPageData())
        var topViewController = self.window?.rootViewController
        if let presentedViewController = topViewController?.presentedViewController {
            topViewController = presentedViewController
        }
        viewController.modalPresentationStyle = .fullScreen
        topViewController?.present(viewController, animated: true, completion: nil)
    }
    
    private func showHomePage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        homeViewController.configure(with: HomeViewModel(homeData: HomeDataBuilder.createBaseObjectForHome()))
        guard let settingsViewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        settingsViewController.configure(with: SettingsViewModel(settingsData: UserData.getCurrentUser() ?? UserData(email: "...loading", password: "...loading", firstName: "...loading", lastName: "...loading", city: "...loading")))
        guard let regionsViewController = storyboard.instantiateViewController(withIdentifier: "RegionsViewController") as? RegionsViewController else { return }
        regionsViewController.configure(with: RegionsViewModel(provinces: ProvincesDataBuilder.createRegionsObject()))
        
        // Set up the Tab Bar Controller to have two tabs
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeViewController, regionsViewController, settingsViewController]
        
        // Make the Tab Bar Controller the root view controller
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


//
//  SceneDelegate.swift
//  animation
//
//  Created by Данил Белецкий on 15.04.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 1. Получаем UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 2. Создаем окно с этой сценой
        window = UIWindow(windowScene: windowScene)
        
        // 3. Создаем корневой ViewController (с анимациями)
        let rootViewController = EasyViewController()
        
        // 4. Оборачиваем в NavigationController для красивого заголовка
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        // 5. Устанавливаем корневой контроллер
        window?.rootViewController = navigationController
        
        // 6. Делаем окно видимым
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Вызывается, когда сцена отключается от приложения
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Вызывается, когда сцена становится активной
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Вызывается, когда сцена перестает быть активной
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Вызывается при переходе из фона в foreground
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Вызывается при переходе в фон
    }
}

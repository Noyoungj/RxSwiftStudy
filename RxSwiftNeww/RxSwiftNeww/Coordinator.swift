//
//  Coordinator.swift
//  RxSwiftNeww
//
//  Created by 노영재 on 2023/02/01.
//

import UIKit

class Coordinate {
    let window : UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let rootViewcontroller = ViewController()
        let navigationViewcontroller = UINavigationController(rootViewController: rootViewcontroller)
        window.rootViewController = navigationViewcontroller
        window.makeKeyAndVisible()
    }
}

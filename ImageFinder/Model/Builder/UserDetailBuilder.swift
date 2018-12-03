//
//  UserDetailBuilder.swift
//  ImageFinder
//
//  Created by Andrea Altea on 03/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

struct UserDetailBuilder: Builder {

    var user: User
    
    func make(from view: UIView?) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let controller = storyboard.instantiateViewController(withIdentifier: String(describing: UserViewController.self)) as? UserViewController else { return nil }
        controller.user = self.user
        return controller
    }
}

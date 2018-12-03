//
//  UserViewController.swift
//  ImageFinder
//
//  Created by Andrea Altea on 02/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit
import Kingfisher

class UserViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.profileImageView.clipsToBounds = true
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.height / 2
        self.container.layer.cornerRadius = 16
        self.container.clipsToBounds = true
        
        self.modalPresentationStyle = .currentContext
        self.view.backgroundColor = .clear
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(autoDismiss(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        self.loadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor.deepNight.withAlphaComponent(0.8)
        }
    }
    
    private func loadContent() {
        
        self.usernameLabel.text = self.user?.username
        self.nameLabel.text = self.user?.name
        
        if let resource = ImageLoader(path: self.user?.avatar(size: .medium)) {
            self.profileImageView.kf.setImage(with: resource)
        }
    }
    
    @objc func autoDismiss(_ sender: UITapGestureRecognizer?) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = .clear
        }) { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func goToProfile(_ sender: Any) {
        
        guard let path = self.user?.links.html,
            let url = URL(string:  path) else {
                return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension UserViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}

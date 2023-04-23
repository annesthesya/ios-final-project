//
//  AuthViewController.swift
//  Final_Project_Notes_App
//
//  Created by Paul Chelaru on 23.04.2023.
//

import UIKit
import LocalAuthentication

class AuthViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50));
        view.addSubview(authButton);
        authButton.center = view.center;
        authButton.setTitle("Authorize", for: .normal);
        authButton.backgroundColor = .systemGray;
        authButton.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside);
    }
    
    @objc func didTapAuthButton() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason,
                                   reply: {[weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Failed to Authenticate", message: "Please try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                        self?.present(alert, animated: true)
                        return;
                    }
                    //show screen
                    //success
                    let vc = UIViewController()
                    vc.title = "Auth Success"
                    vc.view.backgroundColor = .systemRed
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            })
        } else {
            // can not use
            let alert = UIAlertController(title: "Unavailable", message: "You cant use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
        }
    }
}

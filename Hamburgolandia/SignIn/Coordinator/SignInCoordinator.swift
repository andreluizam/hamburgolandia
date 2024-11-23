import UIKit
import Foundation

class SignInCoordinator {
    private let window: UIWindow?
    private let navigationController: UINavigationController?
    
    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let viewModel = SignInViewModel()
        viewModel.coordinator = self
        
        let signInVC = SignInViewController()
        signInVC.viewModel = viewModel
        
        // igual a root view controller
        self.navigationController?.pushViewController(signInVC, animated: true)
                
        window?.rootViewController = self.navigationController
        window?.makeKeyAndVisible()
    }
    
    func createAccount(){
        let createAccountCoordinator = CreateAccountCoordinator(navigationController: self.navigationController!)
        createAccountCoordinator.parentCoordinator = self
        createAccountCoordinator.start()
    }
    
    func goToHome(){
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
    }
}

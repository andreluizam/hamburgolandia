import UIKit
import Foundation

class CreateAccountCoordinator {
    
    private let navigationController: UINavigationController
    
    var parentCoordinator: SignInCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let createAccountViewController = CreateAccountViewController()
        
        
        let viewModel = CreateAccountViewModel()
        createAccountViewController.viewModel = viewModel
        createAccountViewController.viewModel.coordinator = self
        
        navigationController.pushViewController(createAccountViewController, animated: true)
    }
    
    func goToHome() {
        parentCoordinator?.goToHome()
    }
}

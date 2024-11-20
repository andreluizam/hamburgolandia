import UIKit
import Foundation

class CreateAccountCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let createAccountViewController = CreateAccountViewController()
        
        let viewModel = CreateAccountViewModel()
        createAccountViewController.viewModel = viewModel
        
        navigationController.pushViewController(createAccountViewController, animated: true)
    }
}


protocol SignInViewModelDelegate {
    func viewModelDidSet (state : SignInState)
}


class SignInViewModel {
    
    var delegate: SignInViewModelDelegate?
    var coordinator: SignInCoordinator?
    
    var state:SignInState = .none {
        didSet {
            delegate?.viewModelDidSet(state : state)
        }
    }
    
    func sendLogin() {
        self.state = .loading
        print("logando...")
        
        self.state = .goToHome
        
       // self.state = .error("Usuario nao encontrado")
    }
    
    func goToCreateAccount(){
        coordinator!.createAccount()
    }
    
    func goToHome(){
        coordinator!.goToHome()
    }
}

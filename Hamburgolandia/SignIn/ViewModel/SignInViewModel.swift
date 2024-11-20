
protocol SignInViewModelDelegate {
    func viewModelDidSet (state : SignInState)
}


class SignInViewModel {
    
    var delegate: SignInViewModelDelegate?
    
    var state:SignInState = .none {
        didSet {
            delegate?.viewModelDidSet(state : state)
        }
    }
    
    func sendLogin() {
        self.state = .loading
        print("logando...")
        
        self.state = .error("Usuario nao encontrado")

    }
}

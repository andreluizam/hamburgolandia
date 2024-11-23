protocol CreateAccountViewModelDelegate {
    func viewModelDidSet (state : CreateAccountState)
}

class CreateAccountViewModel {
    
    var delegate: CreateAccountViewModelDelegate?
    var coordinator: CreateAccountCoordinator?
    
    var state:CreateAccountState = .none {
        didSet {
            delegate?.viewModelDidSet(state : state)
        }
    }
    
    func sendDataAccount() {
        self.state = .loading
        print("criando conta...")
        
        self.state = .goToHome
        //self.state = .error("email registrado ja encontrado")
    }
    
    func goToHome() {
        self.coordinator?.goToHome()
    }
}

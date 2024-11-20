import UIKit
import Foundation


class CreateAccountViewController : UIViewController {
    
    let name: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .gray
        ed.placeholder = "Entre com o seu nome"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let email: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .gray
        ed.placeholder = "Entre com o seu e-mail"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let password: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .gray
        ed.placeholder = "Entre com a sua senha"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let password2: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .gray
        ed.placeholder = "Confirme sua senha"
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var btnSend: UIButton = {
        let btn = UIButton()
        btn.setTitle("Enviar", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(send), for: .touchUpInside)
        
        return btn
    }()
    
    var viewModel : CreateAccountViewModel! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(name)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(password2)
        view.addSubview(btnSend)
        
        let nameConstraints = [
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            name.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            name.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let emailConstraints = [
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant:10.0),
            email.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let passwordConstraints = [
            password.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            password.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant:10.0),
            password.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let password2Constraints = [
            password2.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            password2.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            password2.topAnchor.constraint(equalTo: password.bottomAnchor, constant:10.0),
            password2.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let btnSendConstraints = [
            btnSend.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            btnSend.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            btnSend.topAnchor.constraint(equalTo: password2.bottomAnchor, constant:10.0),
            btnSend.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        NSLayoutConstraint.activate(nameConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(password2Constraints)
        NSLayoutConstraint.activate(btnSendConstraints)
        
    }
    
    @objc func send() {
        viewModel.sendDataAccount()
    }
}

extension CreateAccountViewController: CreateAccountViewModelDelegate {
    func viewModelDidSet (state : CreateAccountState) {
        switch(state){
        case .none:
            break
        case .loading:
            // progress bar
            break
        case .goToHome:
            // pag princiapl
            break
        case .error(let msg):
            
            let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            break
            
        }    }
}

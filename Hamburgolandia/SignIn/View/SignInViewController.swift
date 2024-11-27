//
//  SignInViewController.swift
//  Hamburgolandia
//
//  Created by André Luiz Alves Martins on 09/11/24.
//

import UIKit

class SignInViewController: UIViewController {
    
    lazy var email: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .red
        ed.placeholder = "Entre com o seu e-mail"
        ed.keyboardType = .emailAddress
        ed.returnKeyType = .next
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var password: UITextField = {
        let ed = UITextField()
        ed.backgroundColor = .systemGray
        ed.placeholder = "Entre com a sua senha"
        ed.returnKeyType = .done
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var btnSend: UIButton = {
        let btn = UIButton()
        btn.setTitle("Enviar", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(clicar), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var btnCreateAccount: UIButton = {
        let btn = UIButton()
        btn.setTitle("Create account", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .yellow
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(createDidTap), for: .touchUpInside)
        
        return btn
    }()
    
    var viewModel : SignInViewModel! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Login"
        
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(btnSend)
        view.addSubview(btnCreateAccount)
        
        let emailConstraints = [
            
            // O CAMPO EMAIL VAI SER PUXADO PARA A ESQUERDA DA TELA
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            // O CAMPO EMAIL VAI SER PUXADO PARA A DIREITA DA TELA
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // O CAMPO EMAIL VAI SER CENTRALIZADO COM BASE NO CENTRO DA TELA
            email.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            // DEFINE A ALTURA DO CAMPO
            email.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let passwordConstraints = [
            
            // O CAMPO SENHA VAI SER PUXADO PARA A ESQUERDA DO CAMPO EMAIL
            password.leadingAnchor.constraint(equalTo: email.leadingAnchor),
            
            // O CAMPO SENHA VAI SER PUXADO PARA A DIREITA DO CAMPO EMAIL
            password.trailingAnchor.constraint(equalTo: email.trailingAnchor),
            
            // O TOPO DO CAMPO SENHA, VAI SER RENTE AO BOTTOM ( PE ) DO CAMPO EMAIL
            // O CONSANT: 10.0, DEFINE O ESPACAMENTO ENTRE ELES
            
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant:10.0),
            
            // DEFINE A ALTURA DO CAMPO SENHA
            password.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let btnSendConstraints = [
            
            // O CAMPO BOTAO VAI SER PUXADO PARA A ESQUERDA DA TELA
            btnSend.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            // O CAMPO BOTAO VAI SER PUXADO PARA A DIREITA DA TELA
            btnSend.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // O TOPO DO CAMPO SENHA, VAI SER RENTE AO BOTTOM ( PE ) DO CAMPO EMAIL
            // O CONSANT: 10.0, DEFINE O ESPACAMENTO ENTRE ELES
            
            btnSend.topAnchor.constraint(equalTo: password.bottomAnchor, constant:10.0),
            
            // DEFINE A ALTURA DO BOTAO
            btnSend.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let btnCreateAccountConstraints = [
            btnCreateAccount.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            btnCreateAccount.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            btnCreateAccount.topAnchor.constraint(equalTo: btnSend.bottomAnchor, constant:10.0),
            btnCreateAccount.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        // Ativo as constraints que criei acima
        
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(btnSendConstraints)
        NSLayoutConstraint.activate(btnCreateAccountConstraints)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func clicar (_ sender: UIButton){
        viewModel.sendLogin()
    }
    
    @objc func createDidTap(_ sender: UIButton){
        viewModel.goToCreateAccount()
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.returnKeyType == .done) {
            self.view.endEditing(true)
            
            return false
        }
        else{
            password.becomeFirstResponder()
        }
        return false
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func viewModelDidSet (state : SignInState) {
        switch(state){
        case .none:
            break
        case .loading:
            // progress bar
            break
        case .goToHome:
            viewModel.goToHome()
            break
        case .error(let msg):
            
            let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            break
            
        }
    }
}

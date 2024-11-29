//
//  SignInViewController.swift
//  Hamburgolandia
//
//  Created by André Luiz Alves Martins on 09/11/24.
//

import UIKit

class SignInViewController: UIViewController {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Entrar"
        lbl.textAlignment = .left
        lbl.textColor = .label
        lbl.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var email: UITextField = {
        let ed = UITextField()
        ed.placeholder = "Entre com o seu e-mail"
        
        ed.attributedPlaceholder = NSAttributedString(
            string: "Entre com a seu e-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        ed.borderStyle = .roundedRect
        ed.keyboardType = .emailAddress
        ed.returnKeyType = .next
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var password: UITextField = {
        let ed = UITextField()
        ed.placeholder = "Entre com a sua senha"
        
        ed.attributedPlaceholder = NSAttributedString(
            string: "Entre com a sua senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        ed.borderStyle = .roundedRect
        ed.returnKeyType = .done
        ed.delegate = self
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var btnSend: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Enviar"
        btn.setTitleColor = .white
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(clicar))
        
        return btn
    }()
    
    lazy var btnCreateAccount: LoadingButton = {
        let btn = LoadingButton()
        
        let fullText = "Não possui uma conta? Crie uma agora"
        
        let attributedString = NSMutableAttributedString(string: fullText)
        
        let range = (fullText as NSString).range(of: "Crie uma agora")
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
        
        btn.button.setAttributedTitle(attributedString, for: .normal)
        
        btn.addTarget(self, action: #selector(createDidTap))
        
        return btn
    }()
    
    lazy var btnGoogle: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Continuar com o Google"
        btn.setTitleColor = .black
        btn.backgroundColor = .white
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        
        return btn
    }()

    let containerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let leftLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rightLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblOr: UILabel = {
        let lbl = UILabel()
        lbl.text = "OU"
        lbl.textColor = .darkGray
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 18, weight: .semibold)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var viewModel : SignInViewModel! {
        didSet{
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        navigationItem.title = ""
        
        view.addSubview(containerView)
        
        containerView.addSubview(lblTitle)
        containerView.addSubview(email)
        containerView.addSubview(password)
        containerView.addSubview(btnSend)
        containerView.addSubview(btnCreateAccount)
        containerView.addSubview(btnGoogle)
        
        containerView.addSubview(containerLine)
        
        containerLine.addSubview(leftLine)
        containerLine.addSubview(rightLine)
        containerLine.addSubview(lblOr)
        
        let containerConstraint = [
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ]
        
        let titleConstraints = [
            lblTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            lblTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            lblTitle.bottomAnchor.constraint(equalTo: email.topAnchor, constant: -10.0)
        ]
        
        let emailConstraints = [
            
            // O CAMPO EMAIL VAI SER PUXADO PARA A ESQUERDA DA TELA
            email.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            
            // O CAMPO EMAIL VAI SER PUXADO PARA A DIREITA DA TELA
            email.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor),
            
            email.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            
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
            btnSend.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            // O CAMPO BOTAO VAI SER PUXADO PARA A DIREITA DA TELA
            btnSend.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            // O TOPO DO CAMPO SENHA, VAI SER RENTE AO BOTTOM ( PE ) DO CAMPO EMAIL
            // O CONSANT: 10.0, DEFINE O ESPACAMENTO ENTRE ELES
            
            btnSend.topAnchor.constraint(equalTo: password.bottomAnchor, constant:10.0),
            
            // DEFINE A ALTURA DO BOTAO
            btnSend.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let btnCreateAccountConstraints = [
            btnCreateAccount.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            btnCreateAccount.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            btnCreateAccount.topAnchor.constraint(equalTo: btnSend.bottomAnchor, constant:10.0),
            btnCreateAccount.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let containerLineConstraints = [
            containerLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerLine.topAnchor.constraint(equalTo: btnCreateAccount.bottomAnchor),
            containerLine.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let leftLineConstraints = [
            leftLine.leadingAnchor.constraint(equalTo: containerLine.leadingAnchor),
            leftLine.trailingAnchor.constraint(equalTo: lblOr.leadingAnchor,constant: -10),
            
            leftLine.centerYAnchor.constraint(equalTo: containerLine.centerYAnchor),
            leftLine.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let rightLineConstraints = [
            rightLine.trailingAnchor.constraint(equalTo: containerLine.trailingAnchor),
            rightLine.leadingAnchor.constraint(equalTo: lblOr.trailingAnchor,constant: +10),
            
            rightLine.centerYAnchor.constraint(equalTo: containerLine.centerYAnchor),
            rightLine.heightAnchor.constraint(equalToConstant: 1)
        ]
        
        let labelOrlConstraints = [
            lblOr.centerXAnchor.constraint(equalTo: containerLine.centerXAnchor),
            lblOr.centerYAnchor.constraint(equalTo: containerLine.centerYAnchor),
            lblOr.widthAnchor.constraint(equalToConstant: 40)
        ]
        
        let btnGoogleConstraints = [
            btnGoogle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            btnGoogle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            btnGoogle.topAnchor.constraint(equalTo: containerLine.bottomAnchor, constant:10.0),
            btnGoogle.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        // Ativo as constraints que criei acima
        
        NSLayoutConstraint.activate(containerConstraint)
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(btnSendConstraints)
        NSLayoutConstraint.activate(btnCreateAccountConstraints)
        
        NSLayoutConstraint.activate(containerLineConstraints)
        NSLayoutConstraint.activate(leftLineConstraints)
        NSLayoutConstraint.activate(rightLineConstraints)
        NSLayoutConstraint.activate(labelOrlConstraints)
        
        NSLayoutConstraint.activate(btnGoogleConstraints)
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
            btnSend.startLoading(true)
            break
        case .goToHome:
            viewModel.goToHome()
            break
        case .error(let msg):
            
            let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
            
            btnSend.startLoading(false)
            
            break
            
        }
    }
}

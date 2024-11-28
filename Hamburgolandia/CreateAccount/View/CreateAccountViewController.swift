import UIKit
import Foundation


class CreateAccountViewController : UIViewController {
    
    let name: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com o seu nome"
        
        ed.attributedPlaceholder = NSAttributedString(
            string: "Entre com o seu nome",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        ed.textColor = .black
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let email: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com o seu e-mail"
        
        ed.attributedPlaceholder = NSAttributedString(
            string: "Entre com o seu e-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        ed.textColor = .black
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let password: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Entre com a sua senha"
        
        ed.attributedPlaceholder = NSAttributedString(
            string: "Entre com a sua senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        ed.textColor = .black
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    let password2: UITextField = {
        let ed = UITextField()
        ed.borderStyle = .roundedRect
        ed.placeholder = "Confirme sua senha"
        ed.attributedPlaceholder = NSAttributedString(
            string: "Confirme sua senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        ed.textColor = .black
        ed.translatesAutoresizingMaskIntoConstraints = false
        return ed
    }()
    
    lazy var btnSend: LoadingButton = {
        let btn = LoadingButton()
        btn.title = "Criar"
        btn.setTitleColor = .black
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(send))
        
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
        
        navigationItem.title = "Criar conta"
        
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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardNotification),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardNotification),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func onKeyboardNotification(notification: Notification) {
        let visible = notification.name == UIResponder.keyboardWillShowNotification
        
        let keyboardFrame = visible
        ? UIResponder.keyboardFrameEndUserInfoKey
        : UIResponder.keyboardFrameBeginUserInfoKey
        
        if let keyboardSize = (notification.userInfo?[keyboardFrame] as? NSValue)?.cgRectValue {
            onKeyboardChanged(visible, height: keyboardSize.height)
        }
    }
    
    func onKeyboardChanged(_ visible: Bool, height: CGFloat){
        if(visible){
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -height / 3
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = 0
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ view: UITapGestureRecognizer){
        self.view.endEditing(true)
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

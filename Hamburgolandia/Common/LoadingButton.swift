import UIKit
import Foundation

class LoadingButton: UIView{
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var button : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        return btn
    }()
    
    var title : String? {
        willSet{
            button.setTitle(newValue, for: .normal)
        }
    }
    
    var setTitleColor : UIColor? {
        willSet{
            button.setTitleColor(newValue, for: .normal)
        }
    }
    
    override var backgroundColor: UIColor? {
        willSet{
            button.backgroundColor = newValue
        }
    }
    
    func addTarget(_ target: Any?, action: Selector){
        button.addTarget(target, action: action, for: .touchUpInside)
    }
    
    let activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    func startLoading(_ loading: Bool){
        if(loading){
            button.setTitle("", for: .normal)
            activityIndicator.startAnimating()
            alpha = 0.5
            button.isEnabled = false
        } else {
            button.setTitle(title, for: .normal)
            activityIndicator.stopAnimating()
            alpha = 1.0
            button.isEnabled = true
        }
    }
    
    private func setupViews() {        
        addSubview(button)
        addSubview(activityIndicator)
        
        let buttonConstraints = [
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        
        let progressConstraints = [
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
        NSLayoutConstraint.activate(progressConstraints)
    }
}

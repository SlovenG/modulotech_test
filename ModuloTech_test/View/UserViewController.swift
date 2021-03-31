//
//  UserViewController.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class UserViewController: UIViewController {
    
    var viewModel: UserViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: UI Variables
    
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 40, right: 0)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = viewModel.firstNameDisplay
        label.textColor = UIColor(named: "mediumBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        
        label.text = viewModel.lastNameDisplay
        label.textColor = UIColor(named: "mediumBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        
        label.text = viewModel.birthDateDisplay
        label.textColor = UIColor(named: "mediumBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var streetCodeLabel: UILabel = {
        let label = UILabel()
        
        label.text = viewModel.streetCodeDisplay
        label.textColor = UIColor(named: "mediumBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var streetLabel: UILabel = {
        let label = UILabel()
        
        label.text = viewModel.streetDisplay
        label.textColor = UIColor(named: "mediumBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        
        label.text = viewModel.cityDisplay
        label.textColor = UIColor(named: "mediumBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var postalCodelabel: UILabel = {
        let label = UILabel()
        
        label.text = viewModel.postalCodeDisplay
        label.textColor = UIColor(named: "mediumBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        
        label.text = viewModel.countryDisplay
        label.textColor = UIColor(named: "mediumBlue")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        
        setupTextfield(textField)
        textField.placeholder = viewModel.firstNameDisplay
        return textField
        
    }()
    
    lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        
        setupTextfield(textField)
        textField.placeholder = viewModel.lastNameDisplay
        return textField
        
    }()
    
    lazy var birthDateTextField: UITextField = {
        let textField = UITextField()
        
        setupTextfield(textField)
        textField.placeholder = viewModel.birthDateDisplay
        return textField
        
    }()
    
    lazy var streetCodeTextField: UITextField = {
        let textField = UITextField()
        
        setupTextfield(textField)
        textField.placeholder = viewModel.streetCodeDisplay
        return textField
        
    }()
    
    lazy var streetTextField: UITextField = {
        let textField = UITextField()
        
        setupTextfield(textField)
        textField.placeholder = viewModel.streetDisplay
        return textField
        
    }()
    
    lazy var cityTextField: UITextField = {
        let textField = UITextField()
        
        setupTextfield(textField)
        textField.placeholder = viewModel.cityDisplay
        return textField
        
    }()
    
    lazy var postalCodeTextField: UITextField = {
        let textField = UITextField()
        
        setupTextfield(textField)
        textField.placeholder = viewModel.postalCodeDisplay
        return textField
        
    }()
    
    lazy var countryTextField: UITextField = {
        let textField = UITextField()
        
        setupTextfield(textField)
        textField.placeholder = viewModel.countryDisplay
        return textField
    }()
    
    init(viewModel: UserViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // init for storyboard instantiation
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = viewModel.title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .clear
        self.setupViews()
        self.bindViews()
        
        self.view.backgroundColor = UIColor(named: "backgroundVC")
        
        viewModel.fetchUser()
        
    }
    
    
    func setupViews() {
        self.view.addSubview(scrollView)
        
        self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        self.scrollView.addSubview(stackView)
        
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 20).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: 20).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        
        
        self.stackView.addArrangedSubview(firstNameLabel)
        self.stackView.addArrangedSubview(firstNameTextField)
        self.firstNameTextField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.9).isActive = true
        
        self.stackView.addArrangedSubview(lastNameLabel)
        self.stackView.addArrangedSubview(lastNameTextField)
        self.lastNameTextField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.9).isActive = true
        
        self.stackView.addArrangedSubview(birthDateLabel)
        self.stackView.addArrangedSubview(birthDateTextField)
        self.birthDateTextField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.9).isActive = true
        
        self.stackView.addArrangedSubview(streetCodeLabel)
        self.stackView.addArrangedSubview(streetCodeTextField)
        self.streetCodeTextField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.9).isActive = true
        
        self.stackView.addArrangedSubview(streetLabel)
        self.stackView.addArrangedSubview(streetTextField)
        self.streetTextField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.9).isActive = true
        
        self.stackView.addArrangedSubview(cityLabel)
        self.stackView.addArrangedSubview(cityTextField)
        self.cityTextField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.9).isActive = true
        
        self.stackView.addArrangedSubview(postalCodelabel)
        self.stackView.addArrangedSubview(postalCodeTextField)
        self.postalCodeTextField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.9).isActive = true
        
        self.stackView.addArrangedSubview(countryLabel)
        self.stackView.addArrangedSubview(countryTextField)
        self.countryTextField.widthAnchor.constraint(equalTo: self.stackView.widthAnchor, multiplier: 0.9).isActive = true
        
    }
    
    func bindViews(){
        
        self.viewModel.firstName.asObservable().bind(to: firstNameTextField.rx.text).disposed(by: disposeBag)
        self.firstNameTextField.rx.text.bind(to: viewModel.firstName).disposed(by: disposeBag)
        
        self.viewModel.lastName.asObservable().bind(to: lastNameTextField.rx.text).disposed(by: disposeBag)
        self.lastNameTextField.rx.text.bind(to: viewModel.lastName).disposed(by: disposeBag)
        
        self.viewModel.birthDate.asObservable().bind(to: birthDateTextField.rx.text).disposed(by: disposeBag)
        self.birthDateTextField.rx.text.bind(to: viewModel.birthDate).disposed(by: disposeBag)
        
        self.viewModel.streetCode.asObservable().bind(to: streetCodeTextField.rx.text).disposed(by: disposeBag)
        self.streetCodeTextField.rx.text.bind(to: viewModel.streetCode).disposed(by: disposeBag)
        
        self.viewModel.street.asObservable().bind(to: streetTextField.rx.text).disposed(by: disposeBag)
        self.streetTextField.rx.text.bind(to: viewModel.street).disposed(by: disposeBag)
        
        self.viewModel.city.asObservable().bind(to: cityTextField.rx.text).disposed(by: disposeBag)
        self.cityTextField.rx.text.bind(to: viewModel.city).disposed(by: disposeBag)
        
        self.viewModel.postalCode.asObservable().bind(to: postalCodeTextField.rx.text).disposed(by: disposeBag)
        self.postalCodeTextField.rx.text.bind(to: viewModel.postalCode).disposed(by: disposeBag)
        
        self.viewModel.country.asObservable().bind(to: countryTextField.rx.text).disposed(by: disposeBag)
        self.countryTextField.rx.text.bind(to: viewModel.country).disposed(by: disposeBag)
        
    }
    
    func setupTextfield(_ textField: UITextField) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField.backgroundColor = UIColor(named: "backgroundCell")
        textField.textColor = UIColor(named: "darkBlue")
        textField.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor(named: "lightGray")?.cgColor
        textField.layer.cornerRadius = 8
    }
    
}

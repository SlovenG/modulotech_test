//
//  RollerShutterViewController.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class RollerShutterViewController: UIViewController {
    
    var viewModel: RollerShutterViewModel!
    var disposeBag = DisposeBag()
    
    // MARK: UI Variables
    
    lazy var gradient: CAGradientLayer = {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor(hexString: "#4BC0C4").cgColor, UIColor(hexString: "#4BC0C4").cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = 18

        self.cardView.layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "#E0CC55")
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = self.viewModel.deviceName
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionSlider: UISlider = {
        let slider = UISlider()
        
        slider.isContinuous = true
        slider.tintColor = .blue
        slider.minimumValue = RollerShutterViewModel.Constants.minPosition
        slider.maximumValue = RollerShutterViewModel.Constants.maxPosition
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.widthAnchor.constraint(equalToConstant: 150).isActive = true
        slider.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
        return slider
    }()
    
    lazy var emptyView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    // MARK: Life Cycle Functions
    init(viewModel: RollerShutterViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // init for storyboard instantiation
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.bindViews()
    }
    
    func setupViews() {
       self.view.addSubview(cardView)
        
        self.cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.cardView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        self.cardView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6).isActive = true
        
        self.cardView.addSubview(stackView)

        self.stackView.centerXAnchor.constraint(equalTo: self.cardView.centerXAnchor).isActive = true
        self.stackView.centerYAnchor.constraint(equalTo: self.cardView.centerYAnchor).isActive = true
        self.stackView.widthAnchor.constraint(equalTo: self.cardView.widthAnchor).isActive = true
        self.stackView.heightAnchor.constraint(equalTo: self.cardView.heightAnchor,multiplier: 0.9).isActive = true
        
        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(emptyView)
        self.stackView.addArrangedSubview(positionLabel)
        self.stackView.addArrangedSubview(positionSlider)
        
        positionSlider.makeUpsideDown()
        self.view.backgroundColor = UIColor(named: "backgroundVC")

    }
    
    func bindViews(){
        // init and bind position data to slider and label
        viewModel.position.subscribe(onNext: { [weak self](position) in
            self?.viewModel.device.value.position = position
        }).disposed(by: disposeBag)
        
        self.positionSlider.value = viewModel.position.value
        self.positionSlider.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: {
                let value = self.positionSlider.value
            
                self.viewModel.position.accept(round(value))
                self.updateGradient()
            }).disposed(by: disposeBag)
        
        viewModel.position.asDriver()
            .map {"Position:" +  String(format: "%g", $0) }
            .drive(self.positionLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    func updateGradient() {
              gradient.locations = [0.0 ,1.0]
          }
          
          override func viewDidLayoutSubviews() {
              super.viewDidLayoutSubviews()

            gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.cardView.frame.size.width, height: self.cardView.frame.size.height * CGFloat(viewModel.positionColor.value))
       
          }
       
}

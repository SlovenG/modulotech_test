//
//  UserViewModel.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

class UserViewModel {
    
    let user = BehaviorRelay<User?>(value: nil)
    let disposeBag = DisposeBag()
    
    var title: String {
        return "User".localized
    }
    
    var firstNameDisplay : String {
        return "FirstName".localized
    }
    
    var lastNameDisplay: String {
        return "LastName".localized
    }
    
    var birthDateDisplay: String {
        return "BirthDate".localized
    }
    
    var streetCodeDisplay: String {
         return "StreetCode".localized
     }
    
    var streetDisplay: String {
         return "Street".localized
     }
    
    var cityDisplay: String {
         return "City".localized
     }
    
    var postalCodeDisplay: String {
         return "PostalCode".localized
     }
    
    var countryDisplay: String {
         return "Country".localized
     }
    
    lazy var firstName: BehaviorRelay<String?> = {
        let relay = BehaviorRelay<String?>(value: nil)
        
        self.user.subscribe(onNext: { relay.accept($0?.firstName) })
            .disposed(by: disposeBag)
        
        return relay
    }()
    
    lazy var lastName: BehaviorRelay<String?> = {
        let relay = BehaviorRelay<String?>(value: nil)
        
        self.user.subscribe(onNext: { relay.accept($0?.lastName) })
            .disposed(by: disposeBag)
        
        return relay
    }()
    
    lazy var birthDate: BehaviorRelay<String?> = {
        let relay = BehaviorRelay<String?>(value: nil)
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        self.user.subscribe(onNext: { user in
            let date = user?.birthDate
            
            relay.accept((date != nil) ? formatter.string(from: date!) : nil) })
            .disposed(by: disposeBag)
        
        return relay
    }()
    
    lazy var streetCode: BehaviorRelay<String?> = {
           let relay = BehaviorRelay<String?>(value: nil)
           
        self.user.subscribe(onNext: { relay.accept($0?.address.streetCode) })
               .disposed(by: disposeBag)
           
           return relay
       }()
    
    lazy var street: BehaviorRelay<String?> = {
        let relay = BehaviorRelay<String?>(value: nil)
        
     self.user.subscribe(onNext: { relay.accept($0?.address.street) })
            .disposed(by: disposeBag)
        
        return relay
    }()
    
    lazy var city: BehaviorRelay<String?> = {
        let relay = BehaviorRelay<String?>(value: nil)
        
     self.user.subscribe(onNext: { relay.accept($0?.address.city) })
            .disposed(by: disposeBag)
        
        return relay
    }()
    
    lazy var postalCode: BehaviorRelay<String?> = {
        let relay = BehaviorRelay<String?>(value: nil)
        
        self.user.subscribe(onNext: { user in
            let postalCode = user?.address.postalCode
            relay.accept((postalCode != nil) ?  String("\(postalCode!)") : "") })
            .disposed(by: disposeBag)
        
        return relay
    }()
    
    lazy var country: BehaviorRelay<String?> = {
        let relay = BehaviorRelay<String?>(value: nil)
        
     self.user.subscribe(onNext: { relay.accept($0?.address.country) })
            .disposed(by: disposeBag)
        
        return relay
    }()
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    func fetchUser() {
        self.userService.fetchUser()
            .subscribe(onNext: { [weak self] user in
                self?.user.accept(user)
            }).disposed(by: disposeBag)
    }
    
}

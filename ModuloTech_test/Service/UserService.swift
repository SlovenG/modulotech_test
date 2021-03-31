//
//  UserService.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import Foundation
import RxSwift


protocol UserServiceProtocol {
    func fetchUser() -> Observable<User>

}

class UserService: UserServiceProtocol {
    
    
    var session = URLSession.shared
    
    private enum Constants {
        static let deviceURL = "http://storage42.com/modulotest/data.json"
    }
    
    
    func fetchUser() -> Observable<User> {

        return Observable.create { observer -> Disposable in
            let task = self.session.dataTask(with: URL(string: Constants.deviceURL)!) { (data, _, _) in
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                    observer.onNext(userResponse.user)
                } catch {
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
}

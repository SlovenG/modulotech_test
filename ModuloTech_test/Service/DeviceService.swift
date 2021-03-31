//
//  DeviceService.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 26/03/2021.
//

import Foundation
import RxSwift


protocol DeviceServiceProtocol {
    func fetchDevices() -> Observable<Devices>
    
    
}

class DeviceService: DeviceServiceProtocol {
    
    var session = URLSession.shared
    
    private enum Constants {
        static let deviceURL = "http://storage42.com/modulotest/data.json"
    }
    
    
    func fetchDevices() -> Observable<Devices> {
        
        return Observable.create { observer -> Disposable in
            let task = self.session.dataTask(with: URL(string: Constants.deviceURL)!) { (data, _, _) in
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return
                }
                
                do {
                    let devices = try JSONDecoder().decode(Devices.self, from: data)
                    observer.onNext(devices)
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

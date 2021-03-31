//
//  RollerShutterViewModel.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

class RollerShutterViewModel {
    
    struct Constants {
        static let minPosition: Float = 0
        static let maxPosition: Float = 100
    }
    
    let device: BehaviorRelay<RollerShutter>
    let position: BehaviorRelay<Float>
    
    let disposeBag = DisposeBag()

    lazy var positionColor: BehaviorRelay<Float> = {
        let relay = BehaviorRelay<Float>(value: 0.5)
        
        self.position.subscribe(onNext: { temperature in
            let t = (temperature - Constants.minPosition) / Constants.maxPosition
            
            relay.accept(t)
            }).disposed(by: disposeBag)
        
        return relay
    }()
    
    var deviceName: String {
        return device.value.deviceName
    }
    
    init(device: Device) {
        let rollerShutter = device as! RollerShutter
        
        self.device = BehaviorRelay(value: rollerShutter)
        self.position = BehaviorRelay(value: rollerShutter.position)
        
        self.position.subscribe(onNext: { position in
            let d = self.device.value
            
            d.position = position
            self.device.accept(d)
        }).disposed(by: disposeBag)
    }
    
}

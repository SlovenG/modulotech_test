//
//  LightViewModel.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

class LightViewModel {
    
     struct Constants {
        static let minIntensity: Float = 0
        static let maxIntensity: Float = 100
    }
    
    let device: BehaviorRelay<Light>
    let intensity: BehaviorRelay<Float>
    let mode: BehaviorRelay<DeviceMode>
    
    let disposeBag = DisposeBag()
    
    lazy var intensityColor: BehaviorRelay<Float> = {
        let relay = BehaviorRelay<Float>(value: 0.5)
        
        self.intensity.subscribe(onNext: { intensity in
            let t = intensity / Constants.maxIntensity
            
            relay.accept(t)
            }).disposed(by: disposeBag)
        
        return relay
    }()
    
    var deviceName: String {
        return device.value.deviceName
    }

    init(device: Device) {
        let light = device as! Light
        
        self.device = BehaviorRelay(value: light)
        self.intensity = BehaviorRelay(value: light.intensity)
        self.mode = BehaviorRelay(value: light.mode)
        
        self.intensity.subscribe(onNext: { intensity in
            let d = self.device.value
            
            d.intensity = intensity
            self.device.accept(d)
        }).disposed(by: disposeBag)
        
        self.mode.subscribe(onNext: { mode in
            let d = self.device.value
            
            d.mode = mode
            self.device.accept(d)
        }).disposed(by: disposeBag)
    }
}

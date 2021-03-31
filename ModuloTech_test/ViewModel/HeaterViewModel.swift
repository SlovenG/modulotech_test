//
//  HeaterViewModel.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 29/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

class HeaterViewModel {
    
    struct Constants {
        static let minTemperature: Float = 7.0
        static let maxTemperature: Float = 28.0
        static let stepTemperature: Float = 0.5
    }
    
    let device: BehaviorRelay<Heater>
    let temperature: BehaviorRelay<Float>
    let mode: BehaviorRelay<DeviceMode>
    
    let disposeBag = DisposeBag()
    
    lazy var temperatureColor: BehaviorRelay<Float> = {
        let relay = BehaviorRelay<Float>(value: 0.5)
        
        self.temperature.subscribe(onNext: { temperature in
            let t =  1 - (temperature - Constants.minTemperature) / (Constants.maxTemperature - Constants.minTemperature)
            
            relay.accept(t)
        }).disposed(by: disposeBag)
        
        return relay
    }()
    
    var deviceName: String {
        return device.value.deviceName
    }
    
    init(device: Device) {
        let heater = device as! Heater
        
        self.device = BehaviorRelay(value: heater)
        self.temperature = BehaviorRelay(value: heater.temperature)
        self.mode = BehaviorRelay(value: heater.mode)
        
        self.temperature.subscribe(onNext: { temperature in
            let d = self.device.value
            
            d.temperature = temperature 
            self.device.accept(d)
        }).disposed(by: disposeBag)
        
        self.mode.subscribe(onNext: { mode in
            let d = self.device.value
            
            d.mode = mode
            self.device.accept(d)
        }).disposed(by: disposeBag)
    }
}

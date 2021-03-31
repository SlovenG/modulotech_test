//
//  DeviceViewModel.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 27/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct DeviceViewModel {
    
    let device: BehaviorRelay<Device>
    
    var deviceName: String {
        return device.value.deviceName
    }
    
    var productType: DeviceTypes {
        return device.value.productType
    }
    
    var intensity: String? {
        guard self.device.value.productType == .light else { return nil }
        let light = device.value as! Light
        
        
            return "Intensity: \(light.intensity)"
    }
    
    var mode: String? {
        if self.device.value.productType == .light {
            let light = device.value as! Light
            
            return "Mode: \(light.mode.rawValue)"
        } else if self.device.value.productType == .heater {
            let heater = device.value as! Heater
            
            return "Mode: \(heater.mode.rawValue)"
        } else {
            return nil
        }
    }
    
    var temperature: String? {
        guard self.device.value.productType == . heater else { return nil }
        let heater = device.value as! Heater
        
        return "Temperature: \(heater.temperature)"
    }
    
    var position: String? {
        guard self.device.value.productType == .rollerShutter else { return nil }
        let rollerShutter = device.value as! RollerShutter
        
        return "Position: \(rollerShutter.position)"
    }
    
    init(device: Device) {
        self.device = BehaviorRelay(value: device)
    }
}

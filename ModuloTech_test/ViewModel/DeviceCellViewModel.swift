//
//  DeviceCellViewModel.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 31/03/2021.
//

import Foundation
import RxCocoa
import RxSwift

struct DeviceCellViewModel {
    
    let device: Device
    
    var deviceName: String {
        return device.deviceName
    }
    
    var value: String {
        switch device.productType {
        case .light:
            let light = (device as! Light)
            return String(format:"Intensity:".localized, Int(light.intensity))
        case .heater:
            
            return String(format: "Temperature:".localized, (device as! Heater).temperature)
        case .rollerShutter:
            let rollerShutter = (device as! RollerShutter)
            return String(format: "Position:".localized, Int(rollerShutter.position))
        }
    }
    
    var mode: String? {
        switch device.productType {
        case .light:
            return (device as! Light).mode.rawValue
        case .heater:
            return (device as! Heater).mode.rawValue
        case .rollerShutter:
            return nil
        }
    }

    init(device: Device) {
        self.device = device
    }
    
}

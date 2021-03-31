//
//  Device.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 26/03/2021.
//

import Foundation
 
class Device: Decodable {
    
    let id: Int
    let deviceName: String
    let productType: DeviceTypes
    
    private enum CodingKeys: String, CodingKey {
        case id
        case deviceName
        case productType
    }
}

class Light: Device {
    
    var intensity: Float
    var mode: DeviceMode
    
    private enum CodingKeys: String, CodingKey {
        case intensity
        case mode
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.intensity = try container.decode(Float.self, forKey: .intensity)
        self.mode = try container.decode(DeviceMode.self,forKey: .mode)
        try super.init(from: decoder)
    }
}

class RollerShutter: Device {
    
    var position: Float
    
    private enum CodingKeys: String, CodingKey {
        case position
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.position = try container.decode(Float.self, forKey: .position)
        try super.init(from: decoder)
    }
}

class Heater: Device {
    
    var temperature: Float
    var mode: DeviceMode
    
    private enum CodingKeys: String, CodingKey {
        case temperature
        case mode
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temperature = try container.decode(Float.self, forKey: .temperature)
        self.mode = try container.decode(DeviceMode.self, forKey: .mode)
        try super.init(from: decoder)
    }
}


enum DeviceMode: String, Decodable {
    case On = "ON"
    case Off = "OFF"
}

enum DeviceTypes: String, Decodable, CaseIterable{
       case light = "Light"
       case heater = "Heater"
       case rollerShutter = "RollerShutter"
   }

struct Devices: Decodable {
    let devices: [Device]
    
    enum DevicesKey: CodingKey {
        case devices
    }
    
    enum DeviceTypeKey: String,CodingKey {
        case type =  "productType"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DevicesKey.self)
        var deviceArrayForType = try container.nestedUnkeyedContainer(forKey: DevicesKey.devices)
        var devices = [Device]()
        
        var devicesArray = deviceArrayForType
        while (!deviceArrayForType.isAtEnd) {
            let device = try deviceArrayForType.nestedContainer(keyedBy: DeviceTypeKey.self)
            let type = try device.decode(DeviceTypes.self, forKey: DeviceTypeKey.type)
            
            switch type {
            case .light:
                devices.append(try devicesArray.decode(Light.self))
            case .heater:
                devices.append(try devicesArray.decode(Heater.self))
            case .rollerShutter:
                devices.append(try devicesArray.decode(RollerShutter.self))
            }
        }
        self.devices = devices
    }
    
    
}

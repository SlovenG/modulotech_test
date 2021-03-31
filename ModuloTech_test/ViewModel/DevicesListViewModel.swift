//
//  DevicesListViewModel.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 27/03/2021.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

class DevicesListViewModel {
    
       
    var title: String {
           return "Devices".localized
       }
    
    // Rx Variables
    
    var devices = BehaviorRelay<[Device]>(value: [])
    
    
    lazy var sectionsCells: BehaviorRelay<[SectionModel<String, Device>]> = {
        
        let sections = BehaviorRelay<[SectionModel<String, Device>]>(value: [])
        
        self.devices
            .map { Dictionary(grouping: $0, by: { $0.productType })
                .map {SectionModel(model: $0.key.rawValue, items: $0.value.map { $0 })}
                .sorted { (section1, section2) -> Bool in
                    section1.model < section2.model
                }
        }.subscribe(onNext: {  [weak self] sectionsDevices in
                      sections.accept(sectionsDevices)
                  }).disposed(by: disposeBag)
        
        return sections
    }()
    
    let disposeBag = DisposeBag()
    
    private let deviceService: DeviceServiceProtocol
    
    init(deviceService: DeviceServiceProtocol = DeviceService()) {
        self.deviceService = deviceService
    }
    
    func fetchDevices(){
        deviceService
            .fetchDevices()
            .map { $0.devices }
            .subscribe(onNext: { [weak self] devices in
                self?.devices.accept(devices)
            }).disposed(by: disposeBag)
    }
    
    func removeItem(at IndexPath: IndexPath) {
        guard self.sectionsCells.value.count > 0 else { return}
        
        var sections = sectionsCells.value
        
        var currentSection =  sections[IndexPath.section]
        currentSection.items.remove(at: IndexPath.row)
        sections[IndexPath.section] = currentSection
        self.sectionsCells.accept(sections)
    }
    
    func updateItem(device: Device) {
        
        var devices = self.devices.value
        
        if let index = devices.firstIndex(where: { $0.id == device.id}) {
            
            devices[index] = device 
            self.devices.accept(devices)
        }
        
        
        
        
    }
}

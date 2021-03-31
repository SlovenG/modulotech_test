//
//  DevicesListViewController.swift
//  ModuloTech_test
//
//  Created by Sloven Graciet on 26/03/2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class DevicesListViewController: UIViewController {
    
    
    let disposeBag = DisposeBag()
    private var viewModel: DevicesListViewModel!
    
    
    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        return tableview
    }()
    
    init(viewModel: DevicesListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    // init for storyboard instantiation
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // prevent weid behaviour on ios12 ()
//               self.edgesForExtendedLayout = []
        
        self.setupViews()
        self.bindViews()
        self.setupCellTapHandling()
        
        viewModel.fetchDevices()
        
    }
    
    // layout views
    private func setupViews() {
        
       
        
        self.navigationItem.title = viewModel.title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        self.view.addSubview(tableView)
        tableView.register(DeviceTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
    
    
    // bind views data to data viewmodel
    private func bindViews() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Device>>(configureCell: { (_, tableview, indexPath, element) -> UITableViewCell in
            let cell: DeviceTableViewCell = tableview.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! DeviceTableViewCell
       
            cell.configure(viewModel: DeviceCellViewModel(device: element))
            return cell
            
        }, titleForHeaderInSection: { (dataSource, sectionIndex) -> String? in
            return dataSource[sectionIndex].model.localized
        })
        
        
        viewModel.sectionsCells.observe(on: MainScheduler.instance).bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        tableView.rx.itemDeleted.subscribe(onNext: { self.viewModel.removeItem(at: $0)})
            .disposed(by: disposeBag)
    }
    
    
    private func setupCellTapHandling() {
        self.tableView.rx.modelSelected(Device.self)
            .subscribe(onNext: { device in
                
                switch device.productType {
                case .light:
                    let lightViewController = LightViewController(viewModel: LightViewModel(device: device))
                    lightViewController.viewModel.device.subscribe(onNext: {[weak self] device in
                        self?.viewModel.updateItem(device: device) }).disposed(by: self.disposeBag)
                    self.navigationController?.pushViewController(lightViewController, animated: true)
                    
                case .heater:
                    let heaterViewController = HeaterViewController(viewModel: HeaterViewModel(device: device))
                    heaterViewController.viewModel.device.subscribe(onNext: {[weak self] device in
                        self?.viewModel.updateItem(device: device) }).disposed(by: self.disposeBag)
                    self.navigationController?.pushViewController(heaterViewController, animated: true)
                    
                case .rollerShutter:
                    let rollerShutterViewController = RollerShutterViewController(viewModel: RollerShutterViewModel(device: device))
                    rollerShutterViewController.viewModel.device.subscribe(onNext: {[weak self] device in
                        self?.viewModel.updateItem(device: device) }).disposed(by: self.disposeBag)
                    self.navigationController?.pushViewController(rollerShutterViewController, animated: true)
                }
            
            }).disposed(by: disposeBag)
    }
}

extension DevicesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

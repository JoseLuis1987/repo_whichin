//
//  MainView.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import Foundation
import UIKit
class MainView: UIViewController {
    lazy var maiViewModel : MainModelView = {
        let viewModel = MainModelView()
        return viewModel
    }()
    let indicator = IndicatorActivity()
    
    private lazy var viewTableDogs: TableViewDogs = {
        let table = TableViewDogs(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(viewTableDogs)
        setAllConstraitnsToUIMain()
        viewTableDogs.dataSource.delegate = self
        self.title = "We love the dogs"
        self.view.backgroundColor = UIColor(hex: 0xf8f8f8)
        if maiViewModel.getLocalDogsSaved().count > 0 {
            for dog in maiViewModel.getLocalDogsSaved() {
                self.viewTableDogs.dataSource.data.value.append(dog)
            }
        }else{
            indicator.showActivityIndicator(uiView: self.view)
            maiViewModel.getAllDogs()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("maiViewModel.getLocalDogsSaved(\(self.maiViewModel.getLocalDogsSaved()))")
        }

        maiViewModel.presenter = self
    }
    func setAllConstraitnsToUIMain(){
        //Activate all constraints
        NSLayoutConstraint.activate([
            viewTableDogs.topAnchor.constraint(equalTo: view.topAnchor),
            viewTableDogs.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewTableDogs.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewTableDogs.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                                                                        ])
    }
}
extension MainView: MainModelViewPresenter{
    func didLoadDogs(dogs: [Dog]) {
        indicator.hideActivityIndicator(uiView: self.view)
        for dog in dogs {
            self.viewTableDogs.dataSource.data.value.append(dog)
        }
    }
    
    func didErrorGetDogs(detailError: String) {
        indicator.hideActivityIndicator(uiView: self.view)
    }
}
extension MainView: TableDataSourceDelegate{
    func didSelectCell(index: IndexPath) {
        print("didSelectCell \(index.row)")
    }
}

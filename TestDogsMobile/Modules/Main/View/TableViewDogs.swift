//
//  TableViewDogs.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import Foundation
import UIKit
class TableViewDogs : UIView {
    var dataSource = TableDataSourceAndDelegate()
    var onPresentDetails:Bool?
    public var tblDogs: UITableView = {
        var tableView =  UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor.gray
        tableView.allowsSelection = true
        tableView.isScrollEnabled = true
        if #available(iOS 11.0, *) {
            tableView.separatorInsetReference = .fromAutomaticInsets
        }
        tableView.sectionIndexColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorEffect = .none
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
        tableView.bounces = false
        tableView.estimatedRowHeight = 120.0
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    private func commonInit() {
        self.addSubview(tblDogs)
        tblDogs.register(UINib(nibName: "DogsCell", bundle: Bundle(for: type(of: self))
        ), forCellReuseIdentifier: "DogsCell")
        tblDogs.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        tblDogs.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        tblDogs.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        tblDogs.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        tblDogs.delegate = dataSource
        tblDogs.dataSource = dataSource
        bindDatos()
    }
    
    func reloadAllData() {
        DispatchQueue.main.async {
            self.tblDogs.reloadData()
        }
        updateElementsHeigth()
        self.layoutIfNeeded()
        self.updateConstraints()
        self.layoutIfNeeded()
    }
    
    func updateElementsHeigth() {
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        DispatchQueue.main.async {
            if let constraint = (self.constraints.filter{$0.firstAttribute == .height}.first) {
                constraint.constant = self.tblDogs.contentSizeHeight + 90
                self.layoutIfNeeded()
                self.updateConstraints()
                self.layoutIfNeeded()
            }
        }
    }

    func bindDatos() {
        self.layoutIfNeeded()
        self.updateConstraints()
        self.layoutIfNeeded()
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async {
                self?.tblDogs.reloadData()
            }
            self?.layoutIfNeeded()
            self?.updateConstraints()
            self?.layoutIfNeeded()
            self?.tblDogs.layoutIfNeeded()
            self?.tblDogs.updateConstraints()
            self?.tblDogs.layoutIfNeeded()
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layoutIfNeeded()
    }
}
@objc protocol TableDataSourceDelegate:AnyObject {
    @objc optional func didSelectCell(index:IndexPath)
}
class TableDataSourceAndDelegate: GenericDataSource<Dog>, UITableViewDataSource, UITableViewDelegate {
    private var presentDetailsStore: Bool? = false
    weak var delegate:TableDataSourceDelegate?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = self.data.value[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DogsCell", for: indexPath) as? DogsCell else { return UITableViewCell() }
        cell.dogData = dataCell
        cell.layoutMargins = UIEdgeInsets(top: 15, left: 10, bottom: 100, right: 10)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    private func tableView(tableView: UITableView,
                 willDisplayCell cell: UITableViewCell,
          forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.didSelectCell?(index: indexPath)
        }
    }
}

//
//  EmployeeListViewController.swift
//  Teltech api
//
//  Created by Josip Marković on 02.03.2023..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

final class EmployeeListViewController: UIViewController, UITableViewDelegate, LoaderProtocol {
    
    weak var employeeListNavigationDelegate: EmployeeListNavigationDelegate?
    private let viewModel: EmployeeListViewModel
    private var dataSource: RxTableViewSectionedAnimatedDataSource<EmployeeListSectionItem>?
    
    public let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()
    
    var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        return view
    }()
    
    private let refreshControl = UIRefreshControl()

    private let disposeBag = DisposeBag()
    
    init(viewModel: EmployeeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindDataSource()
        viewModel.input.onNext(.loadData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension EmployeeListViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupConstraints()
        setupTableView()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        registerCells()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    private func registerCells() {
        tableView.registerCell(EmployeeCell.self)
    }
    
    @objc private func pullToRefresh() {
        viewModel.input.onNext(.pullToRefresh)
    }
    
    private func bindDataSource() {
        disposeBag.insert(viewModel.bindViewModel())
        
        dataSource = RxTableViewSectionedAnimatedDataSource<EmployeeListSectionItem> { (dataSource, tableView, indexPath, rowItem) -> UITableViewCell in
            
            let item = dataSource[indexPath.section].items[indexPath.row]
            let cell: EmployeeCell = tableView.dequeueReusableCell(EmployeeCell.self, for: indexPath)
            
            cell.configure(item: item.item)
            
            return cell
        }
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        guard let safeDataSource = dataSource else { return }
        
        viewModel.output
            .map({ $0.items })
            .bind(to: tableView.rx.items(dataSource: safeDataSource))
            .disposed(by: disposeBag)
        
        viewModel.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (output) in
                
                guard let self = self, let safeEvent = output.event else { return }
                
                switch safeEvent {
                    
                case .reloadData:
                    self.tableView.reloadData()
                case .error(let message):
                    
                    let alertAction = UIAlertAction(title: R.string.localizable.ok(), style: .cancel)
                    self.showAlertWith(title: R.string.localizable.error(),
                                       message: message,
                                       action: alertAction)
                case .openDetails(let employeeItem):
                    self.employeeListNavigationDelegate?.navigateToEmployeeDetails(employee: employeeItem)
                }
            }).disposed(by: disposeBag)
        
        viewModel.loaderPublisher
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (shouldShowLoader) in
                
                guard let self = self else { return }
                if shouldShowLoader{
                    self.showLoader()
                }else{
                    self.refreshControl.endRefreshing()
                    self.hideLoader()
                }
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map({ EmployeeListInput.employeeTapped(indexPath: $0)})
            .bind(to: viewModel.input)
            .disposed(by: disposeBag)
    }
}

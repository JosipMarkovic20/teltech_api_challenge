//
//  DetailsViewController.swift
//  Teltech Employees
//
//  Created by Josip Marković on 06.03.2023..
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit

final class DetailsViewController: UIViewController, UITableViewDelegate {
    
    weak var coordinatorDelegate: CoordinatorDelegate?

    private let detailsView: DetailsView = {
        let view = DetailsView()
        return view
    }()
    
    private let viewModel: DetailsViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("Deinit: \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.input.onNext(.loadData)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent{
            coordinatorDelegate?.viewControllerHasFinished()
        }
    }
}

extension DetailsViewController {
    
    private func setupUI() {
        view.addSubview(detailsView)
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints(){
        detailsView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindViewModel(){
        disposeBag.insert(viewModel.bindViewModel())
        
        viewModel.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (output) in
                
                guard let self = self,
                      let safeEvent = output.event else { return }
                
                switch safeEvent{
                case .error(let message):
                    
                    let alertAction = UIAlertAction(title: R.string.localizable.ok(), style: .cancel)
                    self.showAlertWith(title: R.string.localizable.error(),
                                  message: message,
                                  action: alertAction)
                case .reloadData:
                    guard let safeItem = output.item else { return }
                    self.title = safeItem.name
                    self.detailsView.configure(with: safeItem)
                }
            }).disposed(by: disposeBag)
    }
}


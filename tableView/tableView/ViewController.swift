//
//  ViewController.swift
//  tableView
//
//  Created by 노영재 on 2023/01/03.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift



class ViewController: UIViewController {
    
//    var shownCities = [String]()
//    let allCitis = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    let disposeBag = DisposeBag()
    
    let viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setContent()
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
        searchBar
            .rx.text // RxCocoa의 Observable 속성
            .orEmpty // 옵셔널을 벗기는 것
            .debounce(.microseconds(500), scheduler: MainScheduler.instance) // 500 마이크로초. Float이나 Double은 막히는듯..?
            .distinctUntilChanged() // 새로운 값과 이전 값과 다른지 확인
            .filter { !$0.isEmpty } // 새로운 값이 정말 새롭다면, 비어있지 않은 쿼리를 위해 필터링
            .bind(to: viewModel.textPublishSubject)
            .disposed(by: disposeBag)
        
        viewModel.textPublishSubject.subscribe { [weak self] _ in
            self?.tableView.reloadData()
        } onError: { error in
            print(error)
        } onCompleted: {
            print("com")
        } onDisposed: {
            print("dis")
        }.disposed(by: disposeBag)
    }
    
    func setContent() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.height.equalTo(100)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.bottom.trailing.leading.equalTo(view)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    
}

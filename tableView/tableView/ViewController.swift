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
    var shownCities = [String]()
    let allCitis = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setContent()
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar
            .rx.text // RxCocoa의 Observable 속성
            .orEmpty // 옵셔널을 벗기는 것
            .debounce(.microseconds(500), scheduler: MainScheduler.instance) // 500 마이크로초. Float이나 Double은 막히는듯..?
            .distinctUntilChanged() // 새로운 값과 이전 값과 다른지 확인
            .filter { !$0.isEmpty } // 새로운 값이 정말 새롭다면, 비어있지 않은 쿼리를 위해 필터링
            .subscribe(onNext: { [unowned self] query in //  확인해본 결과 query에는 텍스트 필드의 텍스트가 들어가고 있다.
                self.shownCities = self.allCitis.filter { $0.hasPrefix(query) } // 해당 것에 맞게 필터링
                print(shownCities)
                self.tableView.reloadData() // 테이블 뷰를 다시 로딩
            })
            .disposed(by: disposeBag)
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

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        else {
            return UITableViewCell()
        }
        cell.label.text = shownCities[indexPath.row]
        cell.backgroundColor = .red
        return cell
    }
}

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
            .rx.text
            .orEmpty
            .subscribe(onNext: { [unowned self] query in // 이 부분 덕분에 모든 새로운 값에 대한 알림을 받을 수 있습니다.
                self.shownCities = self.allCitis.filter { $0.hasPrefix(query) } // 도시를 찾기 위한 “API 요청” 작업을 합니다.
                self.tableView.reloadData() // 테이블 뷰를 다시 불러옵니다.
                print("아아")
            })
            .dispose()
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
        return cell
    }
}

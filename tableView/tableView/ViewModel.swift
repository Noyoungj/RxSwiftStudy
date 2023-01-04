//
//  ViewModel.swift
//  tableView
//
//  Created by 노영재 on 2023/01/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ViewModel : NSObject {
    var shownCities = [String]()
    
    let allCitis = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    
    let disposeBag = DisposeBag()

    let textPublishSubject = PublishSubject<String>()
    
    override init() {
        super.init()
        textPublishSubject.subscribe { query in
            self.shownCities = self.allCitis.filter { $0.hasPrefix(query) } // 해당 것에 맞게 필터링
        } onError: { error in
            print(error)
        } onCompleted: {
            print("끝")
        } onDisposed: {
            print("onDisposed")
        }.disposed(by: disposeBag)
    }
}

extension ViewModel : UITableViewDataSource {
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

extension ViewModel : UITableViewDelegate {
    
}



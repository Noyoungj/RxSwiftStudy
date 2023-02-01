//
//  ViewController.swift
//  APIBinding
//
//  Created by 노영재 on 2023/01/05.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setContent()
        // Do any additional setup after loading the view.
    }

    let label : UILabel = {
        let label = UILabel()
        label.text = "예제"
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    func setContent() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}


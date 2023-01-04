//
//  ViewController.swift
//  Login
//
//  Created by 노영재 on 2023/01/04.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    let viewModel = ViewModel()
    let userEmail = "pino-day@test.co.kr"
    let userPassword = "test123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setContent()
        setControl()
    }

    let textFieldLogin : UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디 입력하세요."
        return textField
    }()
    
    let textFieldPassWord : UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 입력하세요."
        return textField
    }()
    
    let buttonGoLogin : UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("로그인 하기", for: .normal)
        return button
    }()
    
    func setContent() {
        view.addSubview(textFieldLogin)
        textFieldLogin.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-50)
            make.width.equalTo(view).multipliedBy(0.7)
        }
        
        view.addSubview(textFieldPassWord)
        textFieldPassWord.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(50)
            make.width.equalTo(view).multipliedBy(0.7)
        }
        
        view.addSubview(buttonGoLogin)
        buttonGoLogin.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(textFieldPassWord.snp.bottom).offset(50)
            make.height.equalTo(70)
            make.width.equalTo(view).multipliedBy(0.7)
        }
    }
    
    func setControl() {
        
        textFieldLogin
            .rx.text
            .orEmpty
            .bind(to: viewModel.emailObserver)
            .disposed(by: disposeBag)
        
        textFieldPassWord
            .rx.text
            .orEmpty
            .bind(to: viewModel.passwordObserver)
            .disposed(by: disposeBag)
        
        viewModel.isValid.bind(to: buttonGoLogin.rx.isEnabled)
                    .disposed(by: disposeBag)

        viewModel.isValid
            .map { $0 ? 1 : 0.3 }
            .bind(to: buttonGoLogin.rx.alpha)
            .disposed(by: disposeBag)
//
        buttonGoLogin
            .rx.tap
            .subscribe { [weak self] _ in
                if self?.userEmail == self?.viewModel.emailObserver.value &&
                                    self?.userPassword == self?.viewModel.passwordObserver.value {
                                    let alert = UIAlertController(title: "로그인 성공", message: "환영합니다", preferredStyle: .alert)
                                    let ok = UIAlertAction(title: "확인", style: .default)
                                    alert.addAction(ok)
                                    self?.present(alert, animated: true, completion: nil)
                                } else {
                                    let alert = UIAlertController(title: "로그인 실패", message: "아이디 혹은 비밀번호를 다시 확인해주세요", preferredStyle: .alert)
                                    let ok = UIAlertAction(title: "확인", style: .default)
                                    alert.addAction(ok)
                                    self?.present(alert, animated: true, completion: nil)
                    }
            } onError: { error in
                print(error)
            } onCompleted: {
                print("complet")
            } onDisposed: {
                print("dispose??")
            }.disposed(by: disposeBag)

    }
}


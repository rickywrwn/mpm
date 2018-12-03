//
//  LoginController.swift
//  mpm
//
//  Created by Ricky Wirawan on 03/12/18.
//  Copyright © 2018 Ricky Wirawan. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView
import SwiftyJSON
import Hue

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupLayout()
        self.hideKeyboardWhenTappedAround()
        print("Login Controller")
    }
    
    @objc func handleLogin(){
        
        if usernameTextField.text == "" || passwordTextField.text == ""{
            let alert = UIAlertController(title: "Message", message: "Data Tidak Lengkap", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            let parameters: Parameters = ["username": usernameTextField.text!,"password": passwordTextField.text!, "action" : "login"]
            Alamofire.request("https://vps.mpm-motor.com/generatetoken/api/login",method: .post, parameters: parameters).responseJSON {
                response in
                
                //olah JSON response
                if let json = response.result.value {
                    print("JSON: \(json)")
                    let json = JSON(response.result.value!)
                    let status = json["status"].boolValue
                    let message = json["message"].stringValue
                    let key = json["key"].stringValue
                    if !status  {
                        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }else{
                        let alert = UIAlertController(title: "Message", message: "Login Berhasil", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            UserDefaults.standard.set(true, forKey:"logged")
                            UserDefaults.standard.set(self.usernameTextField.text!, forKey:"loggedEmail")
                            UserDefaults.standard.set(key, forKey:"loggedKey")
                            UserDefaults.standard.synchronize()
                            self.goToHome()
                            
                        }))
                        
                        self.present(alert, animated: true)
                    }
                }else{
                    print(response.error!)
                    
                }
                
            }
        }
    }
    
    @objc func goToHome(){
        self.dismiss(animated: true)
    }
    
    //tampilan
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
//        iv.image = UIImage.init(named: "logotrans")
        iv.backgroundColor = UIColor.black
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let usernameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.setLeftPaddingPoints(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        textField.textAlignment = .left
        textField.setLeftPaddingPoints(10)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#ea7230")
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleLogin), for: UIControl.Event.touchDown)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupLayout(){
        view.backgroundColor = .white
        
        //usernameTextField
        view.addSubview(usernameTextField)
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usernameTextField.font = UIFont.systemFont(ofSize: 20)
        usernameTextField.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: 60).isActive = true
        usernameTextField.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: 60).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //passwordTextField
        view.addSubview(passwordTextField)
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: 60).isActive = true
        passwordTextField.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: 60).isActive = true
        passwordTextField.topAnchor.constraint(greaterThanOrEqualTo: usernameTextField.bottomAnchor, constant: 15).isActive = true
        
        //loginButton
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: 120).isActive = true
        loginButton.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: 120).isActive = true
        loginButton.topAnchor.constraint(greaterThanOrEqualTo: passwordTextField.bottomAnchor, constant: 35).isActive = true
        
        //Logo
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.bottomAnchor.constraint(greaterThanOrEqualTo: usernameTextField.topAnchor, constant: -50).isActive = true
        
    }
    
    
}

//untuk padding pada textfield
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

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

class LoginController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupLayout()
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
                        let alert = UIAlertController(title: "Message", message: key, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            UserDefaults.standard.set(true, forKey:"logged")
                            UserDefaults.standard.set(self.usernameTextField.text!, forKey:"loggedEmail")
                            UserDefaults.standard.set(key, forKey:"loggedKey")
                            UserDefaults.standard.synchronize()
                            //self.showHome()
                        }))
                        
                        self.present(alert, animated: true)
                    }
                }else{
                    print(response.error!)
                }
                
            }
        }
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
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.borderStyle = .bezel
        textField.placeholder = "Email"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.placeholder = "Password"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.red
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
        usernameTextField.font = UIFont.systemFont(ofSize: 25)
        usernameTextField.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: 60).isActive = true
        usernameTextField.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: 60).isActive = true
        usernameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //passwordTextField
        view.addSubview(passwordTextField)
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.font = UIFont.systemFont(ofSize: 25)
        passwordTextField.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: 60).isActive = true
        passwordTextField.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: 60).isActive = true
        passwordTextField.topAnchor.constraint(greaterThanOrEqualTo: usernameTextField.bottomAnchor, constant: 30).isActive = true
        
        //loginButton
        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: 60).isActive = true
        loginButton.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: 60).isActive = true
        loginButton.topAnchor.constraint(greaterThanOrEqualTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        
        //Logo
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.bottomAnchor.constraint(greaterThanOrEqualTo: usernameTextField.topAnchor, constant: -50).isActive = true
        
    }
    
    
}




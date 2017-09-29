//
//  LoginViewController.swift
//  ProjetoFinal
//
//  Created by Thiago Mota Bastos on 9/27/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.delegate = self
        txtSenha.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        let email = txtEmail.text
        let senha = txtSenha.text
        
        Auth.auth().signIn(withEmail: email!, password: senha!) { (user, error) in
            if error == nil {
                let storage = Database.database().reference()
                let usersRef = storage.child("users")
                
                self.performSegue(withIdentifier: "loginSucedido", sender: self)
            } else {
                print(error)
                var message:String = ""
                
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        message = "E-mail inválido!"
                    case .wrongPassword:
                        message = "E-mail ou senha errados!"
                    case .userNotFound:
                        message = "E-mail ou senha errados!"
                    default:
                        print("none")
                    }
                }
                
                let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

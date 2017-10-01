//
//  CadastroViewController.swift
//  ProjetoFinal
//
//  Created by Thiago Mota Bastos on 9/27/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CadastroViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtConfirmarSenha: UITextField!
    @IBOutlet weak var fotoPessoa: UIImageView!
    
    let fotoPicker = UIImagePickerController()
    
    @IBAction func escolherFoto(_ sender: UIButton) {
        fotoPicker.allowsEditing = false
        fotoPicker.sourceType = .photoLibrary
        fotoPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        fotoPicker.modalPresentationStyle = .popover
        present(fotoPicker, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        fotoPessoa.contentMode = .scaleAspectFit
        fotoPessoa.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.delegate = self
        txtSenha.delegate = self
        txtConfirmarSenha.delegate = self
        fotoPicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleTouchCadastro(_ sender: Any) {
        let nome = txtNome.text
        let email = txtEmail.text
        let senha = txtSenha.text
        let confirmarSenha = txtConfirmarSenha.text
        
        if senha!.characters.count < 6 {
            let alert = UIAlertController(title: "Erro", message: "A senha precisa ter no mínimo 6 caracteres!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            if senha == confirmarSenha {
                Auth.auth().createUser(withEmail: email!, password: senha!) { (user, error) in
                    
                    if error == nil {
                        let storage = Database.database().reference()
                        let usersRef = storage.child("users")
                        
                        let user = Auth.auth().currentUser
                        if let user = user {
                            usersRef.child(user.uid).setValue(["email": user.email, "name": nome!])
                        }
                        
                        self.performSegue(withIdentifier: "cadastroSucedido", sender: self)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Erro", message: "As senhas não estão iguais!", preferredStyle: .alert)
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

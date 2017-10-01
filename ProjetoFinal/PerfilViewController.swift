//
//  PerfilViewController.swift
//  ProjetoFinal
//
//  Created by Danielle Sales de Oliveira on 10/1/17.
//  Copyright © 2017 Thiago Mota Bastos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PerfilViewController: ViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imgPerfil: UIImageView!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtEmailSecundario: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtConfirmarSenha: UITextField!
    
    let fotoPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtNome.delegate = self
        txtEmail.delegate = self
        txtEmailSecundario.delegate = self
        txtSenha.delegate = self
        txtConfirmarSenha.delegate = self
        fotoPicker.delegate = self
        
        txtNome.isUserInteractionEnabled = false
        txtNome.isEnabled = false
        txtEmail.isUserInteractionEnabled = false
        txtEmail.isEnabled = false
        
        txtSenha.isHidden = true
        txtConfirmarSenha.isHidden = true
        
        loadPerfil()
        // Do any additional setup after loading the view.
    }

    func loadPerfil() {
        let storage = Database.database().reference()
        let imageStorage = Storage.storage().reference()
        let user = Auth.auth().currentUser
        
        if let user = user {
            let userRef = storage.child("users").child(user.uid)
            let imageRef = imageStorage.child("images").child(user.uid).child("profile.jpg")
            
            userRef.observe(DataEventType.value, with: { (snapshot) in
                var userData = snapshot.value as? [String : AnyObject] ?? [:]
                print(userData)
                
                self.txtNome.text = userData["name"] as! String
                self.txtEmail.text = userData["email"] as! String
                if userData["emailSecundario"] != nil {
                    self.txtEmailSecundario.text = userData["emailSecundario"] as! String
                }
            })
            
            imageRef.getData(maxSize: 2 * 1024 * 1024) { data, error in
                let image = UIImage(data: data!)
                
                self.imgPerfil.image = image
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imgPerfil.contentMode = .scaleAspectFit
        imgPerfil.image = chosenImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editarFoto(_ sender: Any) {
        fotoPicker.allowsEditing = false
        fotoPicker.sourceType = .photoLibrary
        fotoPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        fotoPicker.modalPresentationStyle = .popover
        present(fotoPicker, animated: true, completion: nil)
    }
    
    @IBAction func salvarModificacoes(_ sender: Any) {
        /*let storage = Database.database().reference()
        let imageStorage = Storage.storage().reference()
        let user = Auth.auth().currentUser
        
        if let user = user {
            
            
            let userRef = storage.child("users").child(user.uid)
        }*/
    }
    
    @IBAction func sairConta(_ sender: Any) {
        
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

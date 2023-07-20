//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Senanur Korkmaz on 3.07.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0 ))
        field.leftViewMode = .always
        field.placeholder = "First Name..."
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0 ))
        field.leftViewMode = .always
        field.placeholder = "Last Name..."
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0 ))
        field.leftViewMode = .always
        field.placeholder = "Email Address..."
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0 ))
        field.leftViewMode = .always
        field.placeholder = "Password..."
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        view.backgroundColor = .white
        
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddProfilePic))
        imageView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: CGFloat((view.width-size)/2) ,
                                 y: view.height/6,
                                 width: size,
                                 height: size )
        imageView.layer.cornerRadius = imageView.width/2.0
        firstNameField.frame = CGRect(x: 30 ,
                                  y: imageView.bottom + 30,
                                  width: scrollView.width - 60,
                                  height: 45 )
        lastNameField.frame = CGRect(x: 30 ,
                                  y: firstNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 45 )
        emailField.frame = CGRect(x: 30 ,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 45 )
        
        passwordField.frame = CGRect(x: 30 ,
                                  y: emailField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 45 )
        registerButton.frame = CGRect(x: 30 ,
                                  y: passwordField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 45 )
        
    }
    
    @objc private func didTapAddProfilePic(){
        presentPhotoActionShert()
    }
    
    @objc private func registerButtonTapped(){
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6 else{
            alertUserLoginError()
            return
        }
    }
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "Woops ",
                                      message: "Please enter all information to register.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismis", style: . cancel))
        present (alert, animated: true)
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        }else if textField == lastNameField{
            emailField.becomeFirstResponder()
        }else if textField == emailField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            registerButtonTapped()
        }
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionShert(){
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture ? ",
                                            preferredStyle: .actionSheet )
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self]_ in
            
            self?.presentCamera()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo", style: .default, handler: { [weak self]_ in
            
            self?.presentPhotoPicker()
            
        }))
        
        present(actionSheet,animated: true )
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true)
        
    }
     
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

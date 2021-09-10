//
//  UserDetailsControllerViewController.swift
//  CV_Builder_App
//
//  Created by Mangesh on 06/09/21.
//

import UIKit

class UserDetailsControllerViewController: UIViewController, UINavigationControllerDelegate, AlertDisplayProtocol {
    
    //MARK:- Outlets
    @IBOutlet weak var userDetailsFieldTableView: UITableView! 
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    //MARK:- Properties
    private var userDetailsViewModel: UserDetailsViewModel
    private let dataSource = GenericDataSource()
    lazy var imagePicker = UIImagePickerController()
    private var profileImageView: UIImageView!
    private var profileHeaderView: UIView!
    private let profileImageViewWidth: CGFloat = 150
    private let profileImageViewHeight: CGFloat = 150
    private let profileHeaderViewHeight: CGFloat = 200
    private lazy var mandatoryFieldMessage = "Please fill all the mandatory fields details"
    private lazy var emailValidationMessage = "Please enter valid email"
    
    //MARK:- Initializers
    init(viewModel: UserDetailsViewModel) {
        userDetailsViewModel = viewModel
        super.init(nibName: "UserDetailsControllerViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Details".localized
        navigationItem.backButtonTitle = ""
        navigationItem.hidesBackButton = true
        dataSource.registerCellWith(tableView: userDetailsFieldTableView)
        addTableHeaderAndFooterView()
        setUpTableDataSource()
        setUpTapGuesture()
        setupKeyBoardNotificationObservers()
    }
    
    override func viewDidLayoutSubviews() {
        profileHeaderView.frame =  CGRect(x: 0, y: 0, width: view.bounds.width, height: profileHeaderViewHeight)
    }
    
    //MARK:- Action methods
    @objc func hideKeyboard() {
        userDetailsFieldTableView.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableViewBottomConstraint.constant = keyboardSize.height - 60
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        tableViewBottomConstraint.constant = 0
    }
    
    @IBAction func nextButtonTapped() {
        view.endEditing(true)
        let result = userDetailsViewModel.isDetailsValid()
        switch result {
        case .success(_):
            userDetailsViewModel.saveUserDetails()
            ScreenManager.sharedInstance.pushWorkExperienceListController(context: self, viewModel: userDetailsViewModel)
        case .failure(let error):
            var message: String
            switch error {
            case .mandatoryFieldError:
                message = mandatoryFieldMessage
            case .emailValidationError:
                message = emailValidationMessage
            }
            displayAlert(message: message, context: self)
        }
    }
    
    //MARK:- Setup methods
    private func setUpTapGuesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        userDetailsFieldTableView.addGestureRecognizer(tapGesture)
    }
    
    private func setupKeyBoardNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setUpTableDataSource() {
        dataSource.array = userDetailsViewModel.getFieldsArray()
        userDetailsFieldTableView.dataSource = dataSource
        userDetailsFieldTableView.delegate = dataSource
    }
    
    private func addTableHeaderAndFooterView() {
        profileHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: profileHeaderViewHeight))
        profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: profileImageViewWidth, height: profileImageViewHeight))
        profileImageView.backgroundColor = UIColor.lightGray
        profileImageView.circularRoundedCorner = true
        profileImageView.clipsToBounds = true
        profileHeaderView.addSubview(profileImageView)
        profileImageView.contentMode = .scaleAspectFill
        if let imageData = userDetailsViewModel.getProfileImageData() {
            profileImageView.image = UIImage(data: imageData, scale: 1)
        } else {
            profileImageView.image = UIImage(named: "profilePlaceHolder")
        }
        profileImageView.tintColor = .white
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerXAnchor.constraint(equalTo: profileHeaderView.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: profileHeaderView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageViewWidth).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageViewHeight).isActive = true
        
        let changeProfileButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        changeProfileButton.backgroundColor = UIColor.white
        changeProfileButton.setImage(UIImage(systemName: "plus"), for: .normal)
        changeProfileButton.tintColor = .black
        changeProfileButton.circularRoundedCorner = true
        changeProfileButton.showBorder(borderWidth: 0.2)
        profileHeaderView.addSubview(changeProfileButton)
        
        changeProfileButton.translatesAutoresizingMaskIntoConstraints = false
        changeProfileButton.leadingAnchor.constraint(equalTo: profileImageView.centerXAnchor, constant: 15).isActive = true
        changeProfileButton.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: -20).isActive = true
        changeProfileButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        changeProfileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileHeaderView.bringSubviewToFront(changeProfileButton)
        changeProfileButton.addTarget(self, action: #selector(getProfilePictureButtonClicked), for: .touchUpInside)
        userDetailsFieldTableView.tableHeaderView = profileHeaderView
    }
}

//MARK:- Image picker delegate methods
extension UserDetailsControllerViewController: UIImagePickerControllerDelegate {
    @objc @IBAction func getProfilePictureButtonClicked() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = image
            userDetailsViewModel.saveProfileImage(imageData: image.jpeg(.medium))
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}

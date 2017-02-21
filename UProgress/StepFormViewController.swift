//
//  DirectionFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 09.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import MBProgressHUD

class StepFormViewController: UIViewController, StepViewProtocol {
    var defaultKeyboardSize: CGFloat!
    var mainView: DirectionsPopupProtocol!
    var presenter: StepPresenter!
    var direction: Direction!
    var user: User! = AuthorizationService.sharedInstance.currentUser
    
    @IBOutlet weak var popupTopMargin: NSLayoutConstraint!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var titleFieldError: UILabel!
    @IBOutlet weak var descriptionFieldError: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancellButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        if CommonFunctions.DeviceData.isOrientationLandscape() {
            if CommonFunctions.DeviceData.isIPad() {
                self.popupTopMargin.constant = 60
            }
            else {
                self.popupTopMargin.constant = self.view.frame.size.width / 5
            }
        }
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
        saveButton.layer.cornerRadius = 8.0
        cancellButton.layer.cornerRadius = 8.0
        
        descriptionField.layer.cornerRadius = 8.0
        descriptionField.layer.borderWidth = 0.3
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        
        let model = DirectionDetailManager()
        presenter = StepPresenter(model: model, view: self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleFieldError.isHidden = true
        descriptionFieldError.isHidden = true
    }
    
    @IBAction func clickSave(_ sender: Any) {
        self.titleFieldError.isHidden = true
        self.descriptionFieldError.isHidden = true
        let directionId: String = String(self.direction.id)
        let parameters: Dictionary<String, AnyObject>! = ["title": self.titleField.text as String! as AnyObject, "description": self.descriptionField.text as String! as AnyObject]
        presenter.createStep(userId: user.nick, directionId: directionId, parameters: parameters )
    }
    @IBAction func clickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    func rotated() {
        if CommonFunctions.DeviceData.isOrientationPortrait() {
            self.popupTopMargin.constant = self.view.frame.size.width / 2
        }
        else {
            self.popupTopMargin.constant = 30
        }
    }
    
    internal func successCreation(step: Step!) {
        self.dismiss(animated: true, completion: {
            self.mainView.successOperation(step: step)
        })
    }
    
    internal func failureCreation(error: ServerError!) {
        let errorsList = error.params!
        if let titleErrorsArr = errorsList["title"] {
            let errorsArr = titleErrorsArr as! [String]
            let titleError: String! = errorsArr.joined(separator: "\n")
            self.titleFieldError.text = titleError
            self.titleFieldError.isHidden = false
            
        }
        
        if errorsList["description"] != nil {
            let errorsArr = errorsList["description"] as! [String]
            let descriptionError: String! = errorsArr.joined(separator: "\n")
            self.descriptionFieldError.text = descriptionError
            self.descriptionFieldError.isHidden = false
        }
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
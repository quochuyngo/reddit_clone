//
//  NewTopicViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/16/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

class NewTopicViewController: UIViewController {

    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var countCharacterLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    let placeHolder = "An interesting title"
    let limitCharacter: Int = 255
    var countCharacter: Int = 255 {
        didSet {
            countCharacterLabel.text = "\(countCharacter)"
        }
    }
    var isContentChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NewTopicViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NewTopicViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        contentTextView.delegate = self
        initView()
    }
    
    @IBAction func postAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        if isContentChanged {
            showWarningPopup()
        } else {
             _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func initView() {
        contentTextView.becomeFirstResponder()
        setPlaceHolder()
    }
    
    func setPlaceHolder() {
        isContentChanged = false
        countCharacterLabel.isHidden = true
        contentTextView.text = placeHolder
        contentTextView.selectedRange = NSRange(location: 0,length: 0)
        contentTextView.textColor = Colors.grayPlaceHolder
    }
    
    func showWarningPopup() {
        let message = "Do you want to discard your post?"
        let alertPopup = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertPopup.addAction(UIAlertAction(title: "Keep edditing", style: .default) {
            _ in
            alertPopup.dismiss(animated: true, completion: nil)
        })
        
        alertPopup.addAction(UIAlertAction(title: "Discard", style: .default) {
            _ in
            alertPopup.dismiss(animated: true, completion: nil)
            _ = self.navigationController?.popViewController(animated: true)
        })
        self.present(alertPopup, animated: true, completion: nil)
    }
    
    func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            bottomConstraint.constant = keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        bottomConstraint.constant = 0
    }
}

extension NewTopicViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        countCharacterLabel.isHidden = false
        isContentChanged = true
        if textView.text.contains(placeHolder) {
            textView.text = textView.text.components(separatedBy: placeHolder)[0]
            contentTextView.textColor = UIColor.black
        } else if textView.text.isEmpty {
            setPlaceHolder()
        }
        
        countCharacter = limitCharacter - textView.text.characters.count
        if countCharacter < 0 {
            countCharacterLabel.textColor = UIColor.red
            postButton.isEnabled = false
        } else {
            countCharacterLabel.textColor = Colors.grayCountLabel
            postButton.isEnabled = true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == placeHolder {
            setPlaceHolder()
        }
        return true
    }
}
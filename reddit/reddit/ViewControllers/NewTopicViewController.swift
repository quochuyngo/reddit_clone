//
//  NewTopicViewController.swift
//  reddit
//
//  Created by Quoc Huy Ngo on 7/16/17.
//  Copyright © 2017 Quoc Huy Ngo. All rights reserved.
//

import UIKit

protocol NewTopicViewControllerDelegate: class {
    func newPost(topic: Topic)
}

class NewTopicViewController: UIViewController {

    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var countCharacterLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    weak var delegate: NewTopicViewControllerDelegate?
    
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
        let topic = Topic(id: Utils.getUUID()
                        , user: User.currentUser
                        , createdDate: Date()
                        , content: contentTextView.text
                        , upVote: 0
                        , downVote: 0
                        , voteState: .none)
        
        delegate?.newPost(topic: topic)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        if isContentChanged {
            showWarningPopup()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func initView() {
        contentTextView.becomeFirstResponder()
        setPlaceHolder()
    }
    
    func setPlaceHolder() {
        isContentChanged = false
        countCharacterLabel.isHidden = true
        postButton.isEnabled = false
        contentTextView.text = placeHolder
        contentTextView.selectedRange = NSRange(location: 0,length: 0)
        contentTextView.textColor = Colors.grayPlaceHolder
    }
    
    func showWarningPopup() {
        let title = "Do you want to discard your post?"
        let alertPopup = UIAlertController(title: title, message: "", preferredStyle: .alert)

        alertPopup.addAction(UIAlertAction(title: "Keep edditing", style: .cancel) {
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
        
        //limit 255 characters in topic
        countCharacter = limitCharacter - textView.text.characters.count
        if countCharacter < 0 {
            countCharacterLabel.textColor = UIColor.red
            postButton.isEnabled = false
        } else {
            countCharacterLabel.textColor = Colors.grayCountLabel
            postButton.isEnabled = true
        }
        
        if textView.text.contains(placeHolder) {
            textView.text = textView.text.components(separatedBy: placeHolder)[0]
            contentTextView.textColor = UIColor.black
        } else if textView.text.isEmpty {
            setPlaceHolder()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == placeHolder {
            setPlaceHolder()
        }
        return true
    }
}

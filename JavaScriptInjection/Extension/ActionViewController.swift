//
//  ActionViewController.swift
//  Extension
//
//  Created by Henry-chime chibuike on 2/13/20.
//  Copyright © 2020 Henry-chime chibuike. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    @IBOutlet var Script: UITextView!
    var pageTitle = ""
    var pageURL = ""
    var pageText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(scriptSelector))
        
        // key board observer
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        //How to interact with the parent app
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    // do stuff!
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    
                    
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
//                    self?.pageText = javaScriptValues["Text"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
        
    }
    
    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": Script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
        UserDefaults.standard.set(Script.text, forKey: "script")
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            Script.contentInset = .zero
        } else {
            Script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        Script.scrollIndicatorInsets = Script.contentInset
        
        let selectedRange = Script.selectedRange
        Script.scrollRangeToVisible(selectedRange)
    }
    
    @objc func scriptSelector(){
        print("Tapped")
        let scriptScreen = UIAlertController(title: "Script Selector", message: "choose Any", preferredStyle: .actionSheet)
        scriptScreen.addAction(UIAlertAction(title: "Hello World", style: .default, handler: {_ in
            
            self.pageText = "Hello World"
            self.Script.text = "alert('\(self.pageText)');"
            
        }))
        scriptScreen.addAction(UIAlertAction(title: "Simple Sum", style: .default, handler: {_ in
            
            self.pageText = "2+3"
            self.Script.text = "alert('2+3 = \(2+3)');"
        }))
        present(scriptScreen, animated: true)

    }
}

//
//  CommentViewController.swift
//  Instagram
//
//  Created by 金子智広 on 1/6/18.
//  Copyright © 2018 tomohiro.kaneko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var postData: PostData?
    
    @IBOutlet weak var commentTextField: UITextView!

    @IBAction func postButton(_ sender: Any) {
        print("DEBUG_PRINT: 投稿ボタンがタップされました。")
        
        guard let postData = postData else {
            return
        }
        
        
        let name = Auth.auth().currentUser?.displayName
            
        //Firebaseに保存する
        let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
        
        let commentBox = commentTextField.text ?? ""
        
        let nameAndComment = name! + ":" + commentBox
    
        postData.comments.append(nameAndComment)
        

// commentsはfirebase上の格納庫のキーを指す。そのキーに入れるのが、postData.comments
        postRef.updateChildValues(["comments": postData.comments])
        
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


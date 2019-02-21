//
//  ExplainViewController.swift
//  kizou
//
//  Created by 中原雄太 on 2019/02/21.
//  Copyright © 2019年 中原雄太. All rights reserved.
//

import UIKit

class ExplainViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    var highSchoolName: UITextField!
    var detailText: UITextView!
    var amountOfMoney: UITextField!
    
    @objc func contributeButtonPushed(_ sender: Any) {
        print("できた")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "投稿",
            style: .plain,
            target: self,
            action: #selector(contributeButtonPushed(_:)))

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        highSchoolName = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        highSchoolName.text = "高校名を記入"
        highSchoolName.textColor = UIColor.lightGray
        highSchoolName.backgroundColor = .gray
        highSchoolName.delegate = self
        highSchoolName.layer.cornerRadius = 5.0
        highSchoolName.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2 - 100)
        self.view.addSubview(highSchoolName)
        
        detailText = UITextView(frame: CGRect(x:0, y:0, width:200, height:100))
        detailText.text = "説明をここに書く"
        detailText.textColor = UIColor.lightGray
        detailText.backgroundColor = .gray
        detailText.layer.cornerRadius = 10.0
        detailText.delegate = self
        // UITextFieldの表示する位置.
        detailText.layer.position = CGPoint(x:self.view.bounds.width/2, y:self.view.bounds.height/2 )
        detailText.layer.borderColor = UIColor.lightGray.cgColor
        // TextViewをviewに追加する.
        self.view.addSubview(detailText)
        
        amountOfMoney = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        amountOfMoney.text = "希望金額を記入"
        amountOfMoney.textColor = UIColor.lightGray
        amountOfMoney.backgroundColor = .gray
        amountOfMoney.delegate = self
        amountOfMoney.layer.cornerRadius = 5.0
        amountOfMoney.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2 + 100)
        self.view.addSubview(amountOfMoney)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if highSchoolName.textColor == UIColor.lightGray {
            highSchoolName.text = nil
            highSchoolName.textColor = UIColor.black
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (highSchoolName.text?.isEmpty)! {
            highSchoolName.text = "高校名を記入"
            highSchoolName.textColor = UIColor.lightGray
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("反応")
        if detailText.textColor == UIColor.lightGray {
            detailText.text = nil
            detailText.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if detailText.text.isEmpty {
            detailText.text = "本文"
            detailText.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let beforeStr: String = detailText.text // 文字列をあらかじめ取得しておく
        if beforeStr.count > 20 { // 10000字を超えた時
            // 以下，範囲指定する
            let last = beforeStr.index(beforeStr.startIndex, offsetBy: 50)
            detailText.text = String(beforeStr[...last])
        }
    }
   


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

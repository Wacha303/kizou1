//
//  ExplainViewController.swift
//  kizou
//
//  Created by 中原雄太 on 2019/02/21.
//  Copyright © 2019年 中原雄太. All rights reserved.
//

import UIKit

class ExplainViewController: UIViewController, UITextViewDelegate {

    var detailText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMyTextView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailText.text = "本文"
        detailText.textColor = UIColor.lightGray
        detailText.delegate = self
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
    

    func setupMyTextView() {
        
        detailText = UITextView(frame: CGRect(x:0, y:0, width:200, height:100))
        detailText.text = "説明をここに書く"
        detailText.backgroundColor = .gray
        
        
        detailText.delegate = self
        
        
        // UITextFieldの表示する位置.
        detailText.layer.position = CGPoint(x:self.view.bounds.width/2, y:self.view.bounds.height/2 )
        
        // TextViewをviewに追加する.
        self.view.addSubview(detailText)
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

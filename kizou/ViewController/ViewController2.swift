//
//  ViewController2.swift
//  kizou
//
//  Created by 中原雄太 on 2019/02/14.
//  Copyright © 2019年 中原雄太. All rights reserved.
//

import UIKit
import AVKit
import MobileCoreServices
import Firebase
import FirebaseStorage

class ViewController2: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var selectButton: UIButton!
    
    var imageView: UIImageView!
    var myTextField: UITextField!
    var contributeButton: UIButton!
    var uploadImage: UIImageView!
    var uploadButton: UIButton!
    var progressView: UIProgressView!
    
    
 
   

    @objc func contributeButtonPushed(_ sender: Any) {
        print("このボタン押したら、投稿完了")
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        //Do whatever you want here
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        selectButton = UIButton()
        uploadImage = UIImageView()
        
        uploadImage.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        uploadImage.layer.cornerRadius = 20.0
        uploadImage.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 + 300)
        uploadImage.backgroundColor = .gray
        self.view.addSubview(uploadImage)
        // サイズを設定する.
        selectButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        // 背景色を設定する.
        selectButton.backgroundColor = UIColor.gray
        // 枠を丸くする.
        selectButton.layer.masksToBounds = true
        // タイトルを設定する(通常時).
        selectButton.setTitle("動画選択", for: UIControl.State.normal)
        selectButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        // タイトルを設定する(ボタンがハイライトされた時).
        selectButton.setTitle("ボタン(押された時)", for: UIControl.State.highlighted)
        selectButton.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        // コーナーの半径を設定する.
        selectButton.layer.cornerRadius = 20.0
        // ボタンの位置を指定する.
        selectButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        // タグを設定する.
        selectButton.tag = 1
        // イベントを追加する.
        selectButton.addTarget(self, action: #selector(selectImage(_:)), for: .touchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(selectButton)
        
        myTextField = UITextField(frame: CGRect(x:0, y:0, width:200, height:30))
        myTextField.text = ""
        
        myTextField.delegate = self
        
        // 枠の線を表示.
        myTextField.borderStyle = UITextField.BorderStyle.roundedRect
        
        // UITextFieldの表示する位置.
        myTextField.layer.position = CGPoint(x:self.view.bounds.width/2, y:self.view.bounds.height/2)
        
        // TextViewをviewに追加する.
        self.view.addSubview(myTextField)
        
        contributeButton = UIButton()
        
        // サイズを設定する.
        contributeButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        // 投稿ボタンの色を設定する.
        contributeButton.backgroundColor = UIColor.red
        // 枠を丸くする.
        contributeButton.layer.masksToBounds = true
        // タイトルを設定する(通常時).
        contributeButton.setTitle("投稿する", for: UIControl.State.normal)
        contributeButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        // タイトルを設定する(ボタンがハイライトされた時).
        contributeButton.setTitle("ボタン(押された時)", for: UIControl.State.highlighted)
        contributeButton.setTitleColor(UIColor.black, for: UIControl.State.highlighted)
        // コーナーの半径を設定する.
        contributeButton.layer.cornerRadius = 20.0
        // ボタンの位置を指定する.
        contributeButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2 + 50)
        
        // イベントを追加する.
        selectButton.addTarget(self, action: #selector(contributeButtonPushed(_:)), for: .touchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(contributeButton)
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        // Points to "images"
        let imagesRef = storageRef.child("images")
        
        // Points to "images/space.jpg"
        // Note that you can use variables to create child values
        let fileName = "space.jpg"
        let spaceRef = imagesRef.child(fileName)
        
//        // File path is "images/space.jpg"
//        let path = spaceRef.fullPath;
//
//        // File name is "space.jpg"
//        let name = spaceRef.name;
//
//        // Points to "images"
//        let images = spaceRef.parent()
        
        //アップロードしたいローカルファイル
        let localFile = URL(string: "path/to/image")!
        
        //ファイルのメタデータを作成
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        //ファイルとメタデータを'images/mountains.jpg'へアップロード
        let uploadtask = storageRef.putFile(from: localFile, metadata: metadata)
        
        //状態の変化、エラー、およびアップロードの完了を確認
        uploadtask.observe(.resume) { snapshot in
            //アップロードが再開された。アップロードの開始時にも発生する。
        }
        uploadtask.observe(.pause) { snapshot in
           // アップロードの一時停止
        }
        uploadtask.observe(.progress) { snapshot in
            //報告された更新のアップロード
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
        }
        
        uploadtask.observe(.success) { snapshot in
            //アップロードが成功した
        }
        
        uploadtask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    //ファイルが存在しない
                    break
                case .unauthorized:
                    //ユーザーがファイルにアクセスする権限を持っていない
                    break
                case .cancelled:
                    //ユーザーがアップロードをキャンセルした
                    break
                    
                case .unknown:
                    //よくわからないエラーが起こった。サーバーの応答を調べる
                    break
                default:
                    //別のエラーが発生しました。これはアップロードを再試行するのに適した場所です。
                    break
                }
            }
        }
  

    }
    
    @objc func selectImage(_ sender: Any) {
        print("aaa")
    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        videoURL = URL(string: "https://devimages.apple.com.edgekey.net/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8")
//        print(videoURL!)
//        imageView.image = previewImageFromVideo(videoURL!)
//        imageView.contentMode = .scaleAspectFit
//        imagePickerController.dismiss(animated: true, completion: nil)
//    }
//
//    func previewImageFromVideo(_ url: URL) -> UIImage? {
//
//        print("動画からサムネイルを作成する")
//        let asset = AVAsset(url: url)
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//        imageGenerator.appliesPreferredTrackTransform = true
//        var time = asset.duration
//        time.value = min(time.value, 2)
//        do {
//            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
//            return UIImage(cgImage: imageRef)
//        } catch {
//            return nil
//        }
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        // 文字数最大を決める.
//        let maxLength: Int = 30
//
//        // 入力済みの文字と入力された文字を合わせて取得.
//        let str = textField.text! + string
//
//        // 文字数がmaxLength以下ならtrueを返す.
//        if str.count < maxLength {
//            return true
//        }
//        print("6文字を超えています")
//        return false
//    }
}


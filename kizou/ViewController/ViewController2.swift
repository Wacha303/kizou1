//
//  ViewController2.swift
//  kizou
//
//  Created by 中原雄太 on 2019/02/14.
//  Copyright © 2019年 中原雄太. All rights reserved.
//

import UIKit
import AVKit
import FirebaseStorage

class ViewController2: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var selectButton: UIButton!
    
    var imageView: UIImageView!
    var myTextField: UITextField!
    var contributeButton: UIButton!
    var uploadImage: UIImageView!
    var uploadButton: UIButton!
    
    let fileName = "USJ.jpeg"
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    @objc func onUploadTapped(_ sender: Any) {
        guard let image = uploadImage.image else { return }
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return }
        let uploadImageRef = imageReference.child(fileName)
        
        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            print("UPLOAD TASK FINISHED")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        
        uploadTask.resume()
    }
    
    @objc func selectImage(_ sender: Any) {
        
        print("UIBarButtonItem。カメラロールから動画を選択")
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
         present(imagePickerController, animated: true, completion: nil)
    }
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
        
        uploadImage.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
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
        contributeButton.backgroundColor = UIColor.gray
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
        contributeButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2 + 100)
        
        // イベントを追加する.
        selectButton.addTarget(self, action: #selector(contributeButtonPushed(_:)), for: .touchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(contributeButton)
        
        uploadButton = UIButton()
        uploadButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        uploadButton.layer.masksToBounds = true
        uploadButton.backgroundColor = UIColor.gray
        uploadButton.layer.cornerRadius = 20.0
        uploadButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height/2 + 100)
        uploadButton.addTarget(self, action: #selector(onUploadTapped(_:)), for: .touchUpInside)
        self.view.addSubview(uploadButton)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        videoURL = URL(string: "https://devimages.apple.com.edgekey.net/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8")
        print(videoURL!)
        imageView.image = previewImageFromVideo(videoURL!)
        imageView.contentMode = .scaleAspectFit
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func previewImageFromVideo(_ url: URL) -> UIImage? {
        
        print("動画からサムネイルを作成する")
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        var time = asset.duration
        time.value = min(time.value, 2)
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            return nil
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // 文字数最大を決める.
        let maxLength: Int = 30
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let str = textField.text! + string
        
        // 文字数がmaxLength以下ならtrueを返す.
        if str.count < maxLength {
            return true
        }
        print("6文字を超えています")
        return false
    }
    
//    @objc func playMovie(_ sender: Any) {
//
//        if let videoURL = videoURL {
//            let player = AVPlayer(url: videoURL)
//            let playerViewController = AVPlayerViewController()
//            playerViewController.player = player
//            present(playerViewController, animated: true) {
//                print("動画再生")
//                playerViewController.player!.play()
//            }
//        }
//    }
    

}

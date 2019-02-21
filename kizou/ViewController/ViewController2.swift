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

class ViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    var videoURL: URL?
    var selectButton: UIButton!
    
    var imageView: UIImageView!
    var uploadImage: UIImageView!
    var progressView: UIProgressView!
    
    
 
   

    @objc func toEplainButtonPushed(_ sender: Any) {
        let explainView = ExplainViewController()
        navigationController?.pushViewController(explainView, animated: true)
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

        setupSelectButton()
        
       
        uploadImage = UIImageView()
        
        uploadImage.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        uploadImage.layer.cornerRadius = 20.0
        uploadImage.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 )
        uploadImage.backgroundColor = .gray
        self.view.addSubview(uploadImage)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "説明を追加する",
            style: .plain,
            target: self,
            action: #selector(toEplainButtonPushed(_:)))


    }
    
   
    func setupSelectButton() {
        selectButton = UIButton()
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
        selectButton.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 + 125)
        // タグを設定する.
        selectButton.tag = 1
        // イベントを追加する.
        selectButton.addTarget(self, action: #selector(selectMovie(_:)), for: .touchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(selectButton)
    }
    
   
   
    @objc func selectMovie(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"] // 動画だけを取れるように
        present(imagePickerController, animated: true, completion: nil)
    }
    
//    func previewImageFromVideo(_ url:URL) -> UIImage? {
//
//        print("動画からサムネイルを生成する")
//        let asset = AVAsset(url:url)
//        let imageGenerator = AVAssetImageGenerator(asset:asset)
//        imageGenerator.appliesPreferredTrackTransform = true
//        var time = asset.duration
//        time.value = min(time.value,2)
//        do {
//            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
//            return UIImage(cgImage: imageRef)
//        } catch {
//            return nil
//        }
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
        //ファイルを作成
        let fileName = "movie.MOV"
        //参照
        let movieRef = Storage.storage().reference().child("movie")
        let fileRef = movieRef.child(fileName)
        let uploadTask = fileRef.putFile(from: videoURL, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            print("成功")
        }
        imagePickerController.dismiss(animated: true, completion: nil)
    }
    
}


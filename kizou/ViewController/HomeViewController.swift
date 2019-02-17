//
//  HomeViewController.swift
//  kizou
//
//  Created by 中原雄太 on 2019/02/16.
//  Copyright © 2019年 中原雄太. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate {
    
    var movieTableView: UITableView!
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieTableView = UITableView(frame: self.view.frame, style: UITableView.Style.grouped) // ‥②
        movieTableView.delegate = self // ‥③
        movieTableView.dataSource = self // ‥③
        movieTableView.estimatedRowHeight = 100
        movieTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "customMovieCell")
        configureTableView()
        self.view.addSubview(movieTableView)
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "プロジェクトを作る",
            style: .plain,
            target: self,
            action: #selector(makeProjectButtonPushed))
        
//        self.navigationItem.rightBarButtonItems = [refleshButtonItem]

    }
    @objc func makeProjectButtonPushed(_ sender: Any) {
        //navigationBarのボタンを押した時のアクション
        let view2 = ViewController2()
        navigationController?.pushViewController(view2, animated: true)
    }
    //④セクション数を指定
    func numberOfSections(in tableView: UITableView) -> Int {
        print("セクション数：1")
        return 1
    }
    //④セクションタイトルを指定
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ここに各高校名？"
    }
    //④セル数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    //④セルを生成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("セルの値を入れていく")
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                                   reuseIdentifier: "aaa\(indexPath.section)-\(indexPath.row)")
        cell.detailTextLabel?.text = "行番号 : \(indexPath.row)"
        //cell.detailTextLabel?.numberOfLines = 0
        //cell.detailTextLabel?.text = textArry[indexPath.row]
        //        cell.imageView?.image = UIImage(named: "dog2.png")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //選ばれたセルが何番か表示する
        print("\(indexPath.row)番のセルが押されました")
    }
    
    //セルのサイズを自動で調整
    func configureTableView() {
        movieTableView.rowHeight = UITableView.automaticDimension
        movieTableView.estimatedRowHeight = 120.0
    }

    
}

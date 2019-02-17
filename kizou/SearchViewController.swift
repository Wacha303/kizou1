//
//  SearchViewController.swift
//  kizou
//
//  Created by 中原雄太 on 2019/02/16.
//  Copyright © 2019年 中原雄太. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate, UINavigationControllerDelegate {
    
    
    var searchBar: UISearchBar!

    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        //タブのアイコンの設定
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar()
        
        searchBar.delegate = self
        
        //位置とサイズを設定
        searchBar.frame = CGRect(x:self.view.frame.width / 2 - 150, y:self.view.frame.height / 2 - 20, width:300, height:40)
        
        //薄文字の説明
        searchBar.placeholder = "高校名を検索してください"
        
        self.view.addSubview(searchBar)
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
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

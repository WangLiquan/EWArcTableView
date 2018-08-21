//
//  ViewController.swift
//  arcTableView
//
//  Created by Ethan.Wang on 2018/8/20.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tableView =  EWArcTableView(frame: CGRect(x: 0, y: 0, width: ScreenInfo.Width, height: ScreenInfo.Height), style: .plain)

    let personNameArray = ["刘一","陈二","张三","李四","王五","赵六","孙七","周八","吴九","郑十"]

    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
    }

    func drawMyView(){
        self.view.addSubview(tableView)
        
        tableView.separatorStyle = .none;
        tableView.isOpaque = false;
        /// 修改cell高度要同时修改rowHeight
        tableView.rowHeight = 90
        tableView.dataSource = self
        tableView.delegate = self
        /// reloadData后contentOffset更改,导致布局效果问题 添加三行
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.showsHorizontalScrollIndicator = false;
        tableView.showsVerticalScrollIndicator = false;
        tableView.register(EWArcTableViewCell.self, forCellReuseIdentifier: EWArcTableViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:  EWArcTableViewCell.identifier) as? EWArcTableViewCell else {
            return EWArcTableViewCell()
        }
        cell.setPersonModel(personHeaderImage: "\(indexPath.row + 1)", personName: personNameArray[indexPath.row])
        return cell
    }
}

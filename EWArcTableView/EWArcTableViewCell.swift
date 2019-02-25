//
//  EWArcTableViewCell.swift
//  arcTableView
//
//  Created by Ethan.Wang on 2018/8/20.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class EWArcTableViewCell: UITableViewCell {

    static let identifier = "EWArcTableViewCell"

    private let personHeadImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        imageView.layer.cornerRadius = 45
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private let rightDetailView: UIView = {
        let view = UIView(frame: CGRect(x: 30, y: 0, width: 210, height: 80))
        view.backgroundColor = UIColor(red: 158/255, green: 154/255, blue: 200/255, alpha: 1)
        view.layer.cornerRadius = 40
        view.layer.masksToBounds = true
        return view
    }()
    private let personNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 97, y: 0, width: 125, height: 80))
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        drawMyView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func drawMyView() {
        self.addSubview(rightDetailView)
        rightDetailView.addSubview(personNameLabel)
        self.addSubview(personHeadImageView)
    }

    func setPersonModel(personHeaderImage: String, personName: String) {
        self.personNameLabel.text = personName
        self.personHeadImageView.image = UIImage(named: personHeaderImage)
    }
}

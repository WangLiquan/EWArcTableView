//
//  EWArcTableView.swift
//  arcTableView
//
//  Created by Ethan.Wang on 2018/8/20.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

struct ScreenInfo {
    static let Frame = UIScreen.main.bounds
    static let Height = Frame.height
    static let Width = Frame.width
    static let navigationHeight:CGFloat = navBarHeight()

    static func isIphoneX() -> Bool {
        return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
    }
    static private func navBarHeight() -> CGFloat {
        return isIphoneX() ? 88 : 64;
    }
}

class EWArcTableView: UITableView {

    var mTotalCellsVisible: Int = 0

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 获取每个cell向右偏移的X
    func getAngleForYOffset(yOffset: CGFloat) -> CGFloat{
        let shift: CGFloat = CGFloat(Int(self.contentOffset.y) % Int(self.rowHeight))
        let percentage: CGFloat = shift / self.rowHeight
        let angle_gap: CGFloat = CGFloat(.pi / Double(mTotalCellsVisible + 1))
        var rows = 0
        if yOffset < 0.0 {
            rows = Int(fabsf(Float(yOffset)) / Float(self.rowHeight))
        }
        return CGFloat(fabsf(Float(angle_gap * (1.0 - percentage)))) + CGFloat(rows) * angle_gap
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        mTotalCellsVisible = Int(self.frame.size.height / self.rowHeight)
        self.setupShapeFormationInVisibleCells()
    }

    func setupShapeFormationInVisibleCells(){
        let indexpaths: Array = self.indexPathsForVisibleRows!
        let totalVisibleCells = indexpaths.count
        let angle_gap = CGFloat(.pi / Double(mTotalCellsVisible + 1))
        let vRadius = (self.frame.size.height - self.rowHeight * 2.0) / 2.0
        let hRadius = self.frame.size.height / 2.0
        let radius = vRadius < hRadius ? vRadius : hRadius
        /// 修改xRadius修改弧度
        let xRadius = radius - 100
        var firstCellAngle: CGFloat = self.getAngleForYOffset(yOffset: self.contentOffset.y)

        for i in 0..<totalVisibleCells{
            let cell: UITableViewCell = self.cellForRow(at: indexpaths[i] )!
            var frame: CGRect = cell.frame
            var angle = firstCellAngle
            firstCellAngle += angle_gap
            angle -= .pi/2
            let x = xRadius * CGFloat(cosf(Float(angle)))
            // 适配
            frame.origin.x = x - 90 + (812 - UIScreen.main.bounds.height) * 95/145
            // cell高度渐变效果,实现最中间的最大,上下逐渐变小
            //            frame.size.height = self.rowHeight * CGFloat(cosf(Float(angle * 0.6)))
            if !x.isNaN {
                cell.frame = frame
            }
        }
    }
}

//
//  EWArcTableView.swift
//  arcTableView
//
//  Created by Ethan.Wang on 2018/8/20.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class EWArcTableView: UITableView {

    private var mTotalCellsVisible: Int = 0

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     获取第一个Cell的X轴偏移量

     @param yOffset tableView.contentOffset.y
     @return 第一个Cell的X轴偏移量
     */
    private func getAngleForYOffset(yOffset: CGFloat) -> CGFloat {
        /// 运用三角函数知识,如果不了解就不用看了.直接拿来用
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
    /**
     在layOutSubViews时调用,为每个Cell重新赋frame.origin.x值,达到弧形展示效果
     */
    private func setupShapeFormationInVisibleCells() {
        /// 能在页面展示的所有cell.indexPath
        let indexpaths: Array = self.indexPathsForVisibleRows!
        let totalVisibleCells = indexpaths.count
        let angle_gap = CGFloat(.pi / Double(mTotalCellsVisible + 1))
        let vRadius = (self.frame.size.height - self.rowHeight * 2.0) / 2.0
        let hRadius = self.frame.size.height / 2.0
        let radius = vRadius < hRadius ? vRadius : hRadius
        /// 可以通过修改xRadius来修改弧度
        let xRadius = radius - 100
        var firstCellAngle: CGFloat = self.getAngleForYOffset(yOffset: self.contentOffset.y)
        // 通过循环获取展示的所有Cell,依次赋值
        for i in 0..<totalVisibleCells {
            let cell: UITableViewCell = self.cellForRow(at: indexpaths[i] )!
            var frame: CGRect = cell.frame
            var angle = firstCellAngle
            firstCellAngle += angle_gap
            angle -= .pi/2
            let x = xRadius * CGFloat(cosf(Float(angle)))
            /// 进行简单适配
            frame.origin.x = x - 90 + (812 - UIScreen.main.bounds.height) * 95/145
            /* 可以通过修改height来实现每个Cell高度渐变效果,页面中间cell最大,上下逐渐变小
            frame.size.height = self.rowHeight * CGFloat(cosf(Float(angle * 0.6)))
             */
            /// 确认x值可用
            if !x.isNaN {
                cell.frame = frame
            }
        }
    }
}

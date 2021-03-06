//
//  HCMineNavBar.swift
//  RxXMLY
//
//  Created by sessionCh on 2017/12/16.
//  Copyright © 2017年 sessionCh. All rights reserved.
//

import UIKit

// MARK:- 常量
fileprivate struct Metric {
        
    static let homeBarWidth: CGFloat = kScreenW
    static let homeBarHeight: CGFloat = 44.0
}

class HCMineNavBar: UIView {
    
    typealias AddBlock = (_ model: HCNavBarItemModel)->Void;
    var itemClicked: AddBlock? = { (_) in
        return
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initMineNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 此处必须指定一个大小
        self.snp.makeConstraints { (make) in
            make.width.equalTo(Metric.homeBarWidth)
            make.height.equalTo(Metric.homeBarHeight)
        }
    }
}

extension HCMineNavBar: HCMineAnchorsable, HCNavUniversalable {
    
    // MARK:- 初始化 我的 导航栏组件
    func initMineNavBar() {
        
        // 消息按钮
        let message = self.universal(model: HCNavBarItemMetric.meMessage) { (model) in
            
            HCLog(model.description)
        }
        
        // 设置
        let setting = self.universal(model: HCNavBarItemMetric.setting) { (model) in
            
            HCLog(model.description)
        }
        
        // 主播工作台
        let mineAnchors = self.mineAnchors(model: HCNavBarItemMetric.mineAnchors) { [weak self] (model) in
            
            guard let `self` = self else { return }
            
            self.itemClicked!(model)
            HCLog(model.description)
        }
        
        // 布局
        message.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        setting.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(message.snp.right).offset(MetricGlobal.margin)
        }
        
        mineAnchors.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}


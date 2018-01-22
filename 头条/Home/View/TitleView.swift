//
//  HomePageViewController.swift
//  头条
//
//  Created by Dx7d9 on 2018/1/18.
//  Copyright © 2018年 Dx7d9. All rights reserved.
//

import UIKit


// MARK: - 定义协议
protocol TitleViewDelegate : class {
    
    /// 获取 TitleView 中选择的 Index 值
    ///
    /// - Parameters:
    ///   - titleView:  titleView
    ///   - index: 最新的Index值
    func titleView(_ titleView : TitleView, selectedIndex index : Int)
}

// MARK: - 全局常量
/// 默认状态下的颜色
private let NormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
/// 选择状态下的暗绿色
private let SelectColor : (CGFloat, CGFloat, CGFloat) = (255,40,40)
/// 缩放的最大值
private let maxScale : CGFloat = 1.2


class TitleView: UIView {
    
    // MARK: - 定义属性
    fileprivate var currentIndex : Int = 0          // 当前的下标值
    fileprivate var margin : CGFloat = 0            // 边距
    weak var delegate : TitleViewDelegate?          // 代理属性
    //    fileprivate var titles: [String]
    
    
    
    // MARK: - 懒加载
    /// 频道列表
    fileprivate lazy var channels : [PageTitleModel] = Test.titledata
    
    /// 定义一个数组, 记录UILabel
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    /// 滚动视图
    fileprivate lazy var scrollView: UIScrollView = {
        
        // 创建UIScrollView, 设置其相关属性
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false     // 点击状态栏时，scrollsToTop == true的控件滚动返回至顶部
        scrollView.bounces = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false // 是否显示水平指示器
        return scrollView
    }()
    
    /// 底部滚动滑块
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        return scrollLine
    }()
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - 设置UI界面
extension TitleView {
    
    /// 设置UI
    fileprivate func setupUI() {
        
        addSubview(scrollView)
//        scrollView.snp.makeConstraints { (make) in
//            make.left.right.top.equalToSuperview()
//            make.height.equalTo(44)
//        }
        scrollView.frame = bounds
        
        setUpTitleLabels()
        setupTitleLabelsFrame()
        setupBottomLineAndScrollLine()
    }
    
    /// 分类底部滑块\长线
    fileprivate func setupBottomLineAndScrollLine() {
        
        /*
         // 1.添加底部长线
         let bottomLine = UIView()
         bottomLine.backgroundColor = UIColor.lightGray
         
         // 底部长线条的高度
         let lineH : CGFloat = 1.0
         //底线的 y: 标题滚动视图的高度 + 导航栏的高度 + 状态栏的高度 - 底线的高度
         bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
         
         // 添加scrollLine 底部长线
         addSubview(bottomLine)
         */
        // 2.设置滑块的 View
        // 获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = Con.darkGreen
        
        let lineX = firstLabel.frame.origin.x
        let lineY = frame.height - Con.scrollLineHeight   //bounds.height - scrollLineH
        let lineW = firstLabel.frame.width
        let lineH = Con.scrollLineHeight
        
        // 设置scrollLine的属性
        scrollLine.frame = CGRect(x: lineX, y: lineY, width: lineW, height: lineH)
        scrollLine.backgroundColor = Con.darkGreen
        scrollView.addSubview(scrollLine)
    }
    
    /// 设置标题栏的分类
    fileprivate func setUpTitleLabels() {
        
        for index in 0 ..< channels.count {
            
            // 1.创建Label, 并设置其相关属性
            let label = UILabel()
            label.text = channels[index].name
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.isUserInteractionEnabled = true       // 开启 Label 用户交互
            label.adjustsFontSizeToFitWidth = true      // 自动调整UILabel的宽度
            
            // 如果标签索引为 0, 设置第一个Label颜色为绿色\否则灰色
            label.textColor = index == 0 ? Con.darkGreen : UIColor.darkGray
            
            // 3.给Label添加手势
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelClick(_:))))
            
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
        
        // 4.设置scrollView的滚动范围
        //scrollView.contentSize = CGSize(width: channels.count * Int(labelWidth), height: 0)
    }
    
    
    
    /// 设置UILabel的位置
    private func setupTitleLabelsFrame() {
        
        /* 临时常量\变量 */
        
        // 标题的个数必须和数组的个数相同
        // let count = channels.count
        
        for (i ,label) in titleLabels.enumerated() {
            
            var labelWidth: CGFloat = 0
            let labelHeight: CGFloat = frame.height - Con.scrollLineHeight
            var labelX: CGFloat = labelWidth * CGFloat(i)
            let labelY: CGFloat = 0
            let itemMargin: CGFloat = 30                // 标题分类Label之间的间距
            
            // MAXFLOAT: 较大的值
            let size = CGSize(width: CGFloat(MAXFLOAT), height: 0)
            
            // 根据文字来计算宽度
            
            let tei = channels[i].name! as NSString
            
            labelWidth = tei.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: label.font], context: nil).width
            
            // 第0个Label的X值,与其他label的x值
            if i == 0 {
                labelX = itemMargin * CGFloat(0.5)
            } else {
                // 上一个Label
                let prelabel = titleLabels[i - 1]
                labelX = CGFloat(prelabel.frame.maxX) + itemMargin
            }
            
            // 2.设置Label的位置
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
        
        // 4.设置scrollView的滚动范围
        scrollView.contentSize = CGSize(width: Int(titleLabels.last!.frame.maxX), height: 0)
    }
}

// MARK: - 监听顶部 label手势点击事件
extension TitleView {
    
    @objc fileprivate func labelClick(_ tap: UITapGestureRecognizer) {
        
        //print(tap.view!)
        
        // 1.获取当前label
        guard let currentLabel = tap.view as? UILabel else { return }
        
        // 如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 2.获取之前的 label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLabel.textColor = Con.darkGreen
        oldLabel.textColor = UIColor.darkGray
        
        // 4.标题字体缩放: 通过改变label的大小
        // CGAffineTransform(scaleX: _ )     : 设置缩放比例.
        // 缩放的同时添加动画
        UIView.animate(withDuration: 0.25) {
            oldLabel.transform = CGAffineTransform.identity         // 还原缩放大小
            currentLabel.transform =  CGAffineTransform(scaleX: maxScale, y: maxScale)
        }
        
        // 5.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        
        // 6.标题居中
        // 本质: 修改标题滚动视图的偏移量
        // 偏移量 = label的中心 - 屏幕宽度的一半
        
        var offset: CGPoint = scrollView.contentOffset
        offset.x = currentLabel.center.x - Con.screenWidth * 0.5
        
        // 最大的偏移量 = scrollView的宽度 - 屏幕的宽度
        let offsetMax = scrollView.contentSize.width - Con.screenWidth
        
        // 如果偏移量小于0, 就不居中, 而且如果偏移量 > 最大偏移量, 让偏移量 = 最大偏移量, 从而实现不居中
        
        if offset.x < 0  {      // 左边超出处理
            offset.x = 0
        } else if (offset.x > offsetMax) {  //右边超出的处理
            offset.x = offsetMax
        }
        
        // 滚动标题,带动画
        scrollView.setContentOffset(offset, animated: true)
        
        // 7.改变滚动条的位置
        
        //给滑块添加动画
        UIView.animate(withDuration: 0.25) {
            
            // 底部滑块的 X 值 == 等于当前Label的 X
            self.scrollLine.frame.origin.x = currentLabel.frame.origin.x
            
            // 底部滑块的宽度 == 当前Label的宽度
            self.scrollLine.frame.size.width = currentLabel.frame.width
        }
        
        // 8.通知代理
        delegate?.titleView(self, selectedIndex: currentIndex)
    }
    
}


// MARK: - 遵守 UIScrollViewDelegate 协议
extension TitleView : UIScrollViewDelegate {
    
    
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        
        /*
         let beforeTitle = titleLabels[sourceIndex]      // 以前的标题
         let targetTitle = titleLabels[targetIndex]      // 目标标题
         
         let templabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
         templabel.text = beforeTitle.text
         templabel.sizeToFit()
         
         let moveX = (targetTitle.frame.origin.x - beforeTitle.frame.origin.x) * progress
         
         let isLimit : Bool = moveX == targetTitle.frame.origin.x - beforeTitle.frame.origin.x
         
         if !isLimit {
         
         if moveX > 0  {
         
         scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) * progress * 2
         //判定下划线是否跳跃
         if progress < 0.5 {
         
         scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) * progress * 2
         scrollLine.frame.origin.x = beforeTitle.frame.origin.x + margin
         }else{
         scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) - (templabel.frame.size.width + self.margin * 2) * (progress * 2 - 1)
         scrollLine.frame.origin.x = beforeTitle.frame.origin.x + margin + (templabel.frame.size.width + self.margin * 2) * (progress * 2 - 1)
         }
         
         }else{
         
         if progress < 0.5 {
         
         scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) * progress * 2
         scrollLine.frame.origin.x = targetTitle.frame.origin.x + margin - (templabel.frame.size.width + self.margin * 2) * (progress * 2 - 1)
         
         }else{
         
         scrollLine.frame.size.width = templabel.frame.size.width + (templabel.frame.size.width + self.margin * 2) - (templabel.frame.size.width + self.margin * 2) * (progress * 2 - 1)
         scrollLine.frame.origin.x = targetTitle.frame.origin.x + margin
         }
         
         
         }
         }
         
         */
        
        
        
        // 1.取出默认的Label/选择状态的Label
        
        /// 默认的label
        let normal_Label = titleLabels[sourceIndex]
        /// 选择状态的label
        let selected_Label = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        
        /// 总的滑动距离值
        let moveTotalX = selected_Label.frame.origin.x - normal_Label.frame.origin.x
        
        /// 总的滑动宽度
        let deltaTotalWidth = selected_Label.frame.width - normal_Label.frame.width
        
        /// 需要滑动的x值
        let moveX = moveTotalX * progress
        
        /// 需要滑动的宽度值
        let deltaW = deltaTotalWidth * progress
        
        // 改变滚动条的位置
        scrollLine.frame.origin.x = normal_Label.frame.origin.x + moveX
        scrollLine.frame.size.width = normal_Label.frame.width + deltaW
        
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出 红\黄\蓝 变化的范围
        let colorDelta = (SelectColor.0 - NormalColor.0, SelectColor.1 - NormalColor.1, SelectColor.2 - NormalColor.2)
        //print("progress",progress)
        
        // 3.2.变化默认Label
        normal_Label.textColor = UIColor(r: SelectColor.0 - colorDelta.0 * progress, g: SelectColor.1 - colorDelta.1 * progress, b: SelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化选择状态下的label
        selected_Label.textColor  = UIColor(r: NormalColor.0+colorDelta.0*progress, g: NormalColor.1+colorDelta.1*progress, b: NormalColor.2+colorDelta.2*progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
        // 5.缩放标题. 拖动contentView，改变字体大小
        let deltaScale: CGFloat = maxScale - 1.0
        
        normal_Label.transform = CGAffineTransform(scaleX: maxScale - deltaScale * progress, y: maxScale - deltaScale * progress)
        selected_Label.transform = CGAffineTransform(scaleX: 1.0 + deltaScale * progress, y: 1.0 + deltaScale * progress)
        
        // 6.标题居中
        // 本质: 修改 标题滚动视图 的偏移量
        // 偏移量 = label 的中心 X 减去屏幕宽度的一半
        
        // 获取之前的 label
        // let old_Label = titleLabels[currentIndex]
        
        var offset: CGPoint = scrollView.contentOffset
        offset.x = selected_Label.center.x - Con.screenWidth * 0.5
        
        // 最大的偏移量 = scrollView的宽度 减去 屏幕的宽度
        let offsetMax = scrollView.contentSize.width - Con.screenWidth
        
        // 如果偏移量小于0, 就不居中, 而且如果偏移量 小于最大偏移量, 让偏移量 = 最大偏移量, 从而实现不居中
        // 左边超出处理
        if offset.x < 0  {
            offset.x = 0
        } else if (offset.x > offsetMax) {  //右边超出的处理
            offset.x = offsetMax
        }
        
        // 滚动标题,带动画
        scrollView.setContentOffset(offset, animated: true)
    }
}

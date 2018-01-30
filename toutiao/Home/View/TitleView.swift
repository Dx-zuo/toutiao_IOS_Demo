//
//  TitleView.swift
//  toutiao
//
//  Created by dx7d9 on 2018/1/29.
//  Copyright © 2018年 dx7d9. All rights reserved.
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
private let normalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
/// 选择状态下的绿色
private let selectColor : (CGFloat, CGFloat, CGFloat) = (255,40,40)
/// 缩放的最大值
private let maxScale : CGFloat = 1.2

class TitleView: UIView {
    
    // MARK: - 定义属性
    fileprivate var currentIndex : Int = 0          // 当前的下标值
    fileprivate var margin : CGFloat = 0            // 边距
    weak var delegate : TitleViewDelegate?          // 代理属性
    
    // MARK: - 懒加载
    /// 频道列表
    fileprivate lazy var channelsList : [HomePageTitleModel] = Test.titleData
    
    /// 记录UILabel
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

//MARK : - 设置界面
extension TitleView {
    func setupUI() {
        //添加ui
        self.addSubview(scrollView)
        
        scrollView.frame = self.bounds
        
        //配置UI
        setUpTitleLabels()
        setupTitleLabelsFrame()
        setupBottomLineAndScrollLine()
    }
    
    /// 分类底部滑块\长线
    fileprivate func setupBottomLineAndScrollLine() {
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
        for index in 0 ..< channelsList.count {
            // 1.创建Label, 并设置其相关属性
            let label = UILabel()
            label.text = channelsList[index].name
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textAlignment = .center
            label.isUserInteractionEnabled = true       // 开启 Label 用户交互
            label.adjustsFontSizeToFitWidth = true      // 自动调整UILabel的宽度
            
            // 如果标签索引为 0, 设置第一个Label颜色为绿色\否则灰色
            label.textColor = index == 0 ? Con.darkGreen : UIColor.darkGray
            
            // 3.给Label添加手势
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelClick(_:))))
            //
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
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
            
            let tei = channelsList[i].name! as NSString
            
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
        // 1.取出默认的Label/选择状态的Label
        
        /// 默认的label
        let normalLabel = titleLabels[sourceIndex]
        /// 选择状态的label
        let selectedLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        /// 总的滑动距离值
        let moveTotalX = selectedLabel.frame.origin.x - normalLabel.frame.origin.x
        
        /// 总的滑动宽度
        let deltaTotalWidth = selectedLabel.frame.width - normalLabel.frame.width
        
        /// 需要滑动的x值
        let moveX = moveTotalX * progress
        
        /// 需要滑动的宽度值
        let deltaW = deltaTotalWidth * progress
        
        // 改变滚动条的位置
        scrollLine.frame.origin.x = normalLabel.frame.origin.x + moveX
        scrollLine.frame.size.width = normalLabel.frame.width + deltaW
        
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出 红\黄\蓝 变化的范围
        let colorDelta = (selectColor.0 - normalColor.0, selectColor.1 - normalColor.1, selectColor.2 - normalColor.2)
        //print("progress",progress)
        
        // 3.2.变化默认Label
        normalLabel.textColor = UIColor(r: selectColor.0 - colorDelta.0 * progress, g: selectColor.1 - colorDelta.1 * progress, b: selectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化选择状态下的label
        selectedLabel.textColor  = UIColor(r: normalColor.0+colorDelta.0*progress, g: normalColor.1+colorDelta.1*progress, b: normalColor.2+colorDelta.2*progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
        // 5.缩放标题. 拖动contentView，改变字体大小
        let deltaScale: CGFloat = maxScale - 1.0
        
        normalLabel.transform = CGAffineTransform(scaleX: maxScale - deltaScale * progress, y: maxScale - deltaScale * progress)
        selectedLabel.transform = CGAffineTransform(scaleX: 1.0 + deltaScale * progress, y: 1.0 + deltaScale * progress)
        
        // 6.标题居中
        // 本质: 修改 标题滚动视图 的偏移量
        // 偏移量 = label 的中心 X 减去屏幕宽度的一半
        
        // 获取之前的 label
        // let old_Label = titleLabels[currentIndex]
        
        var offset: CGPoint = scrollView.contentOffset
        offset.x = selectedLabel.center.x - Con.screenWidth * 0.5
        
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


















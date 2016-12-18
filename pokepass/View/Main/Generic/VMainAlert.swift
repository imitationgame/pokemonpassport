import UIKit

class VMainAlert:UIView
{
    private weak var timer:Timer?
    private weak var layoutTop:NSLayoutConstraint!
    private weak var parentView:UIView?
    private let kAnimationDuration:TimeInterval = 0.2
    private let kTimeOut:TimeInterval = 4
    private let kAlertHeight:CGFloat = 64
    private let kLabelTop:CGFloat = 20
    
    class func Message(message:String)
    {
        DispatchQueue.main.async
        {
            UIApplication.shared.keyWindow!.endEditing(true)
            let alert:VMainAlert = VMainAlert(message:message)
            alert.parentView = UIApplication.shared.keyWindow!.rootViewController!.view
            alert.addToParent()
            alert.animateShow()
        }
    }
    
    convenience init(message:String)
    {
        self.init()
        backgroundColor = UIColor(white:0, alpha:0.8)
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        
        let label:UILabel = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.medium(size:16)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        let views:[String:UIView] = [
            "label":label]
        
        let metrics:[String:CGFloat] = [
            "labelHeight":(kAlertHeight - kLabelTop),
            "labelTop":kLabelTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:|-(labelTop)-[label(labelHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        timer = Timer.scheduledTimer(
            timeInterval:kTimeOut,
            target:self,
            selector:#selector(self.timeOut(sender:)),
            userInfo:nil,
            repeats:false)
    }
    
    deinit
    {
        timer?.invalidate()
    }
    
    func timeOut(sender timer:Timer)
    {
        timer.invalidate()
        animateHide()
    }
    
    //MARK: private
    
    private func addToParent()
    {
        parentView!.addSubview(self)
        
        let views:[String:UIView] = [
            "alert":self]
        
        let metrics:[String:CGFloat] = [
            "alertHeight":kAlertHeight]
        
        parentView!.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[alert]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        parentView!.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"V:[alert(alertHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutTop = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.top,
            relatedBy:NSLayoutRelation.equal,
            toItem:parentView!,
            attribute:NSLayoutAttribute.top,
            multiplier:1,
            constant:-kAlertHeight)
        
        parentView!.addConstraint(layoutTop)
    }
    
    private func animateShow()
    {
        parentView?.layoutIfNeeded()
        layoutTop.constant = 0
        
        UIView.animate(
            withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.parentView?.layoutIfNeeded()
        }
    }
    
    private func animateHide()
    {
        layoutTop.constant = -kAlertHeight
        
        UIView.animate(
            withDuration:kAnimationDuration,
            animations:
        { [weak self] in
            
            self?.parentView?.layoutIfNeeded()
        })
        { [weak self] (done) in
            
            self?.removeFromSuperview()
        }
    }
}

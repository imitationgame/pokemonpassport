import UIKit

class VMainAlert:UIView
{
    fileprivate weak var timer:Timer?
    fileprivate weak var layoutTop:NSLayoutConstraint!
    fileprivate weak var parentView:UIView?
    fileprivate let kAnimationDuration:TimeInterval = 0.2
    fileprivate let kTimeOut:TimeInterval = 3
    fileprivate let kAlertHeight:CGFloat = 64
    fileprivate let kLabelTop:CGFloat = 20
    
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
        backgroundColor = UIColor.complement()
        clipsToBounds = true
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        
        let label:UILabel = UILabel()
        label.backgroundColor = UIColor.clear
        label.font = UIFont.bold(14)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        let views:[String:AnyObject] = [
            "label":label]
        
        let metrics:[String:AnyObject] = [
            "labelHeight":(kAlertHeight - kLabelTop),
            "labelTop":kLabelTop]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(labelTop)-[label(labelHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        timer = Timer.scheduledTimer(timeInterval: kTimeOut, target:self, selector:#selector(self.timeOut(sender:)), userInfo:self, repeats:false)
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
    
    fileprivate func addToParent()
    {
        parentView!.addSubview(self)
        
        let views:[String:AnyObject] = [
            "alert":self]
        
        let metrics:[String:AnyObject] = [
            "alertHeight":kAlertHeight as AnyObject]
        
        parentView!.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[alert]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        parentView!.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[alert(alertHeight)]",
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
    
    fileprivate func animateShow()
    {
        parentView?.layoutIfNeeded()
        layoutTop.constant = 0
        
        UIView.animate(withDuration: kAnimationDuration, animations: { [weak self] in
            
            self?.parentView?.layoutIfNeeded()
        })
        
    }
    
    fileprivate func animateHide()
    {
        layoutTop.constant = -kAlertHeight
        
        UIView.animate(withDuration: kAnimationDuration, animations:
        { [weak self] in
            
            self?.parentView?.layoutIfNeeded()
        }, completion: { [weak self] (done) in
            
            self?.removeFromSuperview()
        })
        
    }
}

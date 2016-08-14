import UIKit

class VMainAlert:UIView
{
    private weak var timer:NSTimer?
    private weak var layoutTop:NSLayoutConstraint!
    private weak var parentView:UIView?
    private let kAnimationDuration:NSTimeInterval = 0.2
    private let kTimeOut:NSTimeInterval = 3
    private let kAlertHeight:CGFloat = 64
    private let kLabelTop:CGFloat = 20
    
    class func Message(message:String)
    {
        dispatch_async(dispatch_get_main_queue())
        {
            UIApplication.sharedApplication().keyWindow!.endEditing(true)
            let alert:VMainAlert = VMainAlert(message:message)
            alert.parentView = UIApplication.sharedApplication().keyWindow!.rootViewController!.view
            alert.addToParent()
            alert.animateShow()
        }
    }
    
    convenience init(message:String)
    {
        self.init()
        backgroundColor = UIColor.complement()
        clipsToBounds = true
        userInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        
        let label:UILabel = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.font = UIFont.bold(14)
        label.textColor = UIColor.blackColor()
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        let views:[String:AnyObject] = [
            "label":label]
        
        let metrics:[String:AnyObject] = [
            "labelHeight":(kAlertHeight - kLabelTop),
            "labelTop":kLabelTop]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-10-[label]-10-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(labelTop)-[label(labelHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        timer = NSTimer.scheduledTimerWithTimeInterval(kTimeOut, target:self, selector:#selector(self.timeOut(sender:)), userInfo:self, repeats:false)
    }
    
    deinit
    {
        timer?.invalidate()
    }
    
    func timeOut(sender timer:NSTimer)
    {
        timer.invalidate()
        animateHide()
    }
    
    //MARK: private
    
    private func addToParent()
    {
        parentView!.addSubview(self)
        
        let views:[String:AnyObject] = [
            "alert":self]
        
        let metrics:[String:AnyObject] = [
            "alertHeight":kAlertHeight]
        
        parentView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-0-[alert]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        parentView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[alert(alertHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutTop = NSLayoutConstraint(
            item:self,
            attribute:NSLayoutAttribute.Top,
            relatedBy:NSLayoutRelation.Equal,
            toItem:parentView!,
            attribute:NSLayoutAttribute.Top,
            multiplier:1,
            constant:-kAlertHeight)
        
        parentView!.addConstraint(layoutTop)
    }
    
    private func animateShow()
    {
        parentView?.layoutIfNeeded()
        layoutTop.constant = 0
        
        UIView.animateWithDuration(kAnimationDuration)
        { [weak self] in
            
            self?.parentView?.layoutIfNeeded()
        }
    }
    
    private func animateHide()
    {
        layoutTop.constant = -kAlertHeight
        
        UIView.animateWithDuration(kAnimationDuration, animations:
        { [weak self] in
            
            self?.parentView?.layoutIfNeeded()
        })
        { [weak self] (done) in
            
            self?.removeFromSuperview()
        }
    }
}
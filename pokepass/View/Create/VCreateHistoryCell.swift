import UIKit

class VCreateHistoryCell:UICollectionViewCell
{
    private weak var label:UILabel!
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        clipsToBounds = true
        backgroundColor = UIColor.white

        
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: public
    
    func config(model:MCreateAnnotation)
    {
        
    }
}

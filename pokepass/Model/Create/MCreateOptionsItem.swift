import UIKit

class MCreateOptionsItem
{
    let image:String
    let title:String
    
    init(image:String, title:String)
    {
        self.image = image
        self.title = title
    }
    
    //MARK: public
    
    func config(cell:VCreateOptionsCell)
    {
        cell.label.text = title
        cell.image.image = UIImage(named:image)
    }
    
    func selected(controller:CCreate)
    {
    }
}

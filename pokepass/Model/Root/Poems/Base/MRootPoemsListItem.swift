import UIKit
import FirebaseDatabase

class MRootPoemsListItem
{
    var itemStatus:MRootPoemsListItemStatus?
    let status:DInfraPoem.DInfraPoemStatus
    let poemId:String
    let title:String
    let userId:String
    let created:NSTimeInterval
    let lastEdit:NSTimeInterval
    let likes:Int
    var text:String?
    var cellWidth:CGFloat
    var marginHorizontal:CGFloat
    var marginVertical:CGFloat
    var cellSize:CGSize?
    var userName:String?
    var attributedString:NSAttributedString?
    private var completion:((error:String?) -> ())?
    private let kMaxHeight:CGFloat = 10000
    private let drawingOptions:NSStringDrawingOptions
    
    init(poemId:String, json:[String:AnyObject])
    {
        let fPoem:FDatabaseModelPoem = FDatabaseModelPoem(json:json)
        self.poemId = poemId
        status = fPoem.status
        title = fPoem.title
        userId = fPoem.userId
        created = NSTimeInterval(fPoem.created)
        lastEdit = NSTimeInterval(fPoem.lastEdited)
        likes = fPoem.likes
        drawingOptions = NSStringDrawingOptions([NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading])
        cellWidth = 0
        marginHorizontal = 0
        marginVertical = 0
        itemStatus = MRootPoemsListItemStatus.None(self)
    }
    
    private func loadUserName()
    {
        let fUser:FDatabaseModelUser = FDatabaseModelUser()
        let property:String = fUser.kKeyName
        
        FMain.sharedInstance.database.listenUser(userId, property:property)
        { [weak self] (snapshot) in
            
            self?.userName = snapshot.value as? String
            self?.loadPoem()
        }
    }
    
    private func loadPoem()
    {
        FMain.sharedInstance.storage.loadPoem(poemId)
        { [weak self] (poem, error) in
            
            if self != nil
            {   
                if poem == nil
                {
                    self!.text = ""
                }
                else
                {
                    self!.text = poem
                }
                
                self!.completion?(error:error)
            }
            
            self?.completion = nil
        }
    }
    
    //MARK: public
    
    func completed()
    {
        itemStatus = MRootPoemsListItemStatus.Ready(self)
    }
    
    func errored(error:String)
    {
        itemStatus = MRootPoemsListItemStatus.Error(self, error:error)
    }
    
    func loadData(completion:((error:String?) -> ()))
    {
        itemStatus = MRootPoemsListItemStatus.Downloading(self)
        self.completion = completion
        
        loadUserName()
    }
    
    func measureString(attributes:[String:AnyObject], cellWidth:CGFloat, marginHorizontal:CGFloat, marginVertical:CGFloat)
    {
        attributedString = NSAttributedString(string:text!, attributes:attributes)
        self.cellWidth = cellWidth
        self.marginVertical = marginVertical
        self.marginHorizontal = marginHorizontal
        let maxWidth:CGFloat = cellWidth - (marginHorizontal + marginHorizontal)
        let boundingSize:CGSize = CGSizeMake(maxWidth, kMaxHeight)
        let rect:CGRect = attributedString!.boundingRectWithSize(boundingSize, options:drawingOptions, context:nil)
        let height:CGFloat = ceil(rect.maxY)
        let totalHeight:CGFloat = height + marginVertical + marginVertical
        cellSize = CGSizeMake(cellWidth, totalHeight)
    }
    
    func accept()
    {
    }
}
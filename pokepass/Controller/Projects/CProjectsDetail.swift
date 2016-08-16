import UIKit

class CProjectsDetail:CMainController
{
    weak var viewDetail:VProjectsDetail!
    let model:MProjectsDetail
    let item:MProjectsItem
    
    init(item:MProjectsItem)
    {
        model = MProjectsDetail()
        self.item = item
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func loadView()
    {
        let viewDetail:VProjectsDetail = VProjectsDetail(controller:self)
        self.viewDetail = viewDetail
        view = viewDetail
    }
    
    //MARK: private
    
    private func createGPX()
    {
        
    }
    
    func poemFile() -> NSURL?
    {
        let poemText:String = itemText.text
        var poemUrl:NSURL? = NSURL(fileURLWithPath:NSTemporaryDirectory()).URLByAppendingPathComponent(kPoemFileName)
        
        do
        {
            try poemText.writeToURL(poemUrl!, atomically:true, encoding:NSUTF8StringEncoding)
        }
        catch
        {
            poemUrl = nil
        }
        
        return poemUrl
    }
    
    //MARK: public
    
    func share()
    {
        viewDetail.showLoading()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        { [weak self] in
        
            self?.createGPX()
        }
    }
}
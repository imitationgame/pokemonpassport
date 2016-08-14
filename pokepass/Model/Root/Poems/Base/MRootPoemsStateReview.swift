import Foundation

class MRootPoemsStateReview:MRootPoemsState
{
    private let kTitle:String = "Review"
    
    init()
    {
        let controllerType:CRootList.Type = CRootListReview.self
        let state:DInfraPoem.DInfraPoemStatus = DInfraPoem.DInfraPoemStatus.Review
        super.init(controllerType:controllerType, state:state, title:kTitle)
    }
}
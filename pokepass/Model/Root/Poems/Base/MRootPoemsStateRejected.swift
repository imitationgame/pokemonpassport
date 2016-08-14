import Foundation

class MRootPoemsStateRejected:MRootPoemsState
{
    private let kTitle:String = "Rejected"
    
    init()
    {
        let controllerType:CRootList.Type = CRootListRejected.self
        let state:DInfraPoem.DInfraPoemStatus = DInfraPoem.DInfraPoemStatus.Rejected
        super.init(controllerType:controllerType, state:state, title:kTitle)
    }
}
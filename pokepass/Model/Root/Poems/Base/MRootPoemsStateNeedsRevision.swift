import Foundation

class MRootPoemsStateNeedsRevision:MRootPoemsState
{
    private let kTitle:String = "Needs Revision"
    
    init()
    {
        let controllerType:CRootList.Type = CRootListNeedsRevision.self
        let state:DInfraPoem.DInfraPoemStatus = DInfraPoem.DInfraPoemStatus.NeedsRevision
        super.init(controllerType:controllerType, state:state, title:kTitle)
    }
}
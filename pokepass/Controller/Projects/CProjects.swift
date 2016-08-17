import UIKit

class CProjects:CMainController
{
    weak var viewProjects:VProjects!
    let model:MProjects
    
    init()
    {
        model = MProjects()
        
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadProjects()
    }
    
    override func loadView()
    {
        let viewProjects:VProjects = VProjects(controller:self)
        self.viewProjects = viewProjects
        view = viewProjects
    }
    
    //MARK: private
    
    private func loadProjects()
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))
        {
            let sorter:NSSortDescriptor = NSSortDescriptor(key:"name", ascending:true, selector:#selector(NSString.caseInsensitiveCompare))
            let sorters:[NSSortDescriptor] = [sorter]
            DManager.sharedInstance.managerPokePass.fetchManagedObjects(
                DPokePassProject.self,
                sorters:sorters)
            { [weak self] (modelProjects) in
                
                var projects:[MProjectsItem] = []
                
                for project:DPokePassProject in modelProjects
                {
                    let item:MProjectsItem = MProjectsItem(model:project)
                    projects.append(item)
                }
                
                self?.model.items = projects
                
                dispatch_async(dispatch_get_main_queue())
                { [weak self] in
                    
                    self?.viewProjects.modelLoaded()
                }
            }
        }
    }
}
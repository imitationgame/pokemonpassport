import UIKit

class MSettingsMenuItemMetrics:MSettingsMenuItem
{
    weak var cellMetrics:VSettingsCellMetrics!
    let options:[MSettingsMenuItemMetricsOption]
    private let kCellHeight:CGFloat = 80
    
    init()
    {
        let reusableIdentifier:String = VSettingsCellMetrics.reusableIdentifier()
        let optionInternational:MSettingsMenuItemMetricsOptionInternational = MSettingsMenuItemMetricsOption.International()
        let optionUs:MSettingsMenuItemMetricsOptionUs = MSettingsMenuItemMetricsOption.Us()
        
        options = [
            optionInternational,
            optionUs
        ]
        
        super.init(reusableIdentifier:reusableIdentifier, cellHeight:kCellHeight)
    }
    
    override func config(cell:VSettingsCell, controller:CSettings)
    {
        let countOptions:Int = options.count
        cellMetrics = cell as! VSettingsCellMetrics
        cellMetrics.segmented.removeAllSegments()
        cellMetrics.segmented.addTarget(self, action:#selector(self.actionSegmented(sender:)), forControlEvents:UIControlEvents.ValueChanged)
        
        for index:Int in 0 ..< countOptions
        {
            let option:MSettingsMenuItemMetricsOption = options[index]
            let optionName:String = option.name
            cellMetrics.segmented.insertSegmentWithTitle(optionName, atIndex:index, animated:false)
        }
        
        showSelected()
    }
    
    @objc func actionSegmented(sender segmented:UISegmentedControl)
    {
        let selected:Int = segmented.selectedSegmentIndex
        let optionSelected:MSettingsMenuItemMetricsOption = options[selected]
        MSettings.sharedInstance.model!.measures = optionSelected.measure
        DManager.sharedInstance.managerPokePass.saver.save(false)
    }
    
    //MARK: private
    
    private func showSelected()
    {
        let measures:DPokePassSettings.DPokePassSettingsMeasure = MSettings.sharedInstance.model!.measures
        let countOptions:Int = options.count
        
        for index:Int in 0 ..< countOptions
        {
            let option:MSettingsMenuItemMetricsOption = options[index]
            
            if option.measure == measures
            {
                cellMetrics.segmented.selectedSegmentIndex = index
                
                break
            }
        }
    }
}
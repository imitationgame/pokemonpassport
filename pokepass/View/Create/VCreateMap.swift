import UIKit
import MapKit

class VCreateMap:MKMapView, MKMapViewDelegate
{
    weak var controller:CCreate!
    let span:MKCoordinateSpan
    var polyLine:MKPolyline?
    private var userCoordinate:CLLocationCoordinate2D!
    private let kSpanSize:CLLocationDegrees = 0.01
    private let kPolylineWidth:CGFloat = 7
    
    init(controller:CCreate)
    {
        span = MKCoordinateSpan(latitudeDelta:kSpanSize, longitudeDelta:kSpanSize)
        
        super.init(frame:CGRectZero)
        self.controller = controller
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        rotateEnabled = false
        scrollEnabled = true
        zoomEnabled = true
        pitchEnabled = false
        mapType = MKMapType.Standard
        showsBuildings = true
        showsPointsOfInterest = true
        showsCompass = true
        showsScale = true
        showsTraffic = true
        delegate = self
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    //MARK: private
    
    //MARK: public
    
    func centerLocation(locationCoordinate:CLLocationCoordinate2D)
    {
        let region:MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, span)
        setRegion(region, animated:true)
    }
    
    func mapView(mapView:MKMapView, rendererForOverlay overlay:MKOverlay) -> MKOverlayRenderer
    {
        let polyline:MKPolyline = overlay as! MKPolyline
        let renderer:MKPolylineRenderer = MKPolylineRenderer(polyline:polyline)
        renderer.lineWidth = kPolylineWidth
        renderer.strokeColor = UIColor.main()
        
        return renderer
    }
    
    func mapView(mapView:MKMapView, viewForAnnotation annotation:MKAnnotation) -> MKAnnotationView?
    {
        let modelAnnotation:MCreateAnnotation = annotation as! MCreateAnnotation
        let reusableIdentifier:String = modelAnnotation.reusableIdentifier
        var view:MKAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(reusableIdentifier)
        
        if view == nil
        {
            view = modelAnnotation.view()
        }
        else
        {
            view!.annotation = modelAnnotation
        }
        
        return view
    }
}
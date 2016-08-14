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
    
    private func getRoute()
    {
        let userPlacemark:MKPlacemark = MKPlacemark(coordinate:userCoordinate, addressDictionary:nil)
        let userMapItem:MKMapItem = MKMapItem(placemark:userPlacemark)
        let restaurantPlacemark:MKPlacemark = MKPlacemark(coordinate:restaurantCoordinate, addressDictionary:nil)
        let restaurantMapItem:MKMapItem = MKMapItem(placemark:restaurantPlacemark)
        let request:MKDirectionsRequest = MKDirectionsRequest()
        request.source = userMapItem
        request.destination = restaurantMapItem
        request.transportType = MKDirectionsTransportType.Any
        let directions:MKDirections = MKDirections(request:request)
        
        directions.calculateDirectionsWithCompletionHandler
            { [weak self] (directionsResponse, error) in
                
                if self != nil
                {
                    if error == nil && directionsResponse != nil
                    {
                        let routes:[MKRoute] = directionsResponse!.routes
                        
                        if !routes.isEmpty
                        {
                            let route:MKRoute = routes.first!
                            self?.useRoute(route)
                        }
                    }
                }
        }
    }
    
    private func useRoute(route:MKRoute)
    {
        controller.model.shortestRoute = route
        let travelTimeMinutes:NSTimeInterval = route.expectedTravelTime / kMinutesPerSecond
        let distanceMiles:CLLocationDistance = route.distance * kMetersPerMile
        let numberFormatter:NSNumberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        numberFormatter.maximumFractionDigits = 1
        let distanceString:String = numberFormatter.stringFromNumber(distanceMiles)!
        numberFormatter.maximumFractionDigits = 0
        let travelTimeString:String = numberFormatter.stringFromNumber(travelTimeMinutes)!
        let transportString:String
        
        switch route.transportType
        {
        case MKDirectionsTransportType.Walking:
            
            transportString = NSLocalizedString("VRestaurantMainMapperMap_walking", comment:"")
            
            break
            
        case MKDirectionsTransportType.Automobile:
            
            transportString = NSLocalizedString("VRestaurantMainMapperMap_driving", comment:"")
            
            break
            
        default:
            
            transportString = ""
            
            break
        }
        
        let directionsString:String = String(format:NSLocalizedString("VRestaurantMainMapperMap_distance", comment:""), travelTimeString, transportString, distanceString)
        controller.model.directionsString = directionsString
        
        NSNotification.postDirectionsReady()
        
        let newPolyLine:MKPolyline = route.polyline
        
        dispatch_async(dispatch_get_main_queue())
        { [weak self] in
            
            if self != nil
            {
                if self!.polyLine != nil
                {
                    self!.removeOverlay(self!.polyLine!)
                }
                
                self!.polyLine = newPolyLine
                self!.addOverlay(newPolyLine, level:MKOverlayLevel.AboveRoads)
            }
        }
    }
    
    private func addAnotations(addUser:Bool)
    {
        let venueName:String = controller.model.name
        let annotationVenue:MRestaurantMainMapAnnotation = MRestaurantMainMapAnnotation.Venue(restaurantCoordinate, name:venueName)
        var annotations:[MRestaurantMainMapAnnotation] = []
        annotations.append(annotationVenue)
        
        if addUser
        {
            let userCoordinate:CLLocationCoordinate2D = MSession.sharedInstance.currentLocation()
            let annotationUser:MRestaurantMainMapAnnotation = MRestaurantMainMapAnnotation.User(userCoordinate)
            annotations.append(annotationUser)
        }
        
        addAnnotations(annotations)
    }
    
    //MARK: public
    
    func centerUser()
    {
        let region:MKCoordinateRegion = MKCoordinateRegionMake(userCoordinate, span)
        setRegion(region, animated:true)
    }
    
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
        let modelAnnotation:MRestaurantMainMapAnnotation = annotation as! MRestaurantMainMapAnnotation
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
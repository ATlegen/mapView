//
//  TableViewController.swift
//  mapView
//
//  Created by Assemgul on 19.12.2023.
//

import UIKit
import MapKit

class TableViewController: UITableViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate {
    
    let arrayHotels = [Hotels(hotel: "Riu Plaza Fisherman's Wharf", address: "2500 Mason Street, Рыбацкая пристань, Сан-Франциско, CA", imageName: "Riu", lat: 37.807, long: -122.413),
        Hotels(hotel: "AC Hotel by Marriott San Jose Santa Clara", address: "2970 Lakeside Drive, Санта-Клара, CA", imageName: "Jose Santa", lat: 37.385, long: -121.981),
        Hotels(hotel: "The Cottages Hotel", address: "1704 El Camino Real, Менло-Парк, CA", imageName: "Cottages", lat: 37.459, long: -122.193),
        Hotels(hotel: "Hyatt House San Ramon", address: "2323 San Ramon Valley, Сан-Рамон, CA", imageName: "San Ramon", lat: 37.778, long: -121.978)]
    
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Запрашиваем разрешение на использование местоположения пользователя
        locationManager.requestWhenInUseAuthorization()
        
        // delegate нужен для функции didUpdateLocations, которая вызывается при обновлении местоположения (для этого прописали CLLocationManagerDelegate выше)
        locationManager.delegate = self
        
        // Запускаем слежку за пользователем
        locationManager.startUpdatingLocation()

      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayHotels.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = "\(arrayHotels[indexPath.row].hotel)"
        
        let labelAddress = cell.viewWithTag(1001) as! UILabel
        labelAddress.text = "\(arrayHotels[indexPath.row].address)"
        
        let imageView = cell.viewWithTag(1002) as! UIImageView
        imageView.image = UIImage(named: arrayHotels[indexPath.row].imageName)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 127
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! ViewController
        
        detailVC.hotel = arrayHotels[indexPath.row]
    
        navigationController?.show(detailVC, sender: self)
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

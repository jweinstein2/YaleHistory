//
//  MapViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//



import UIKit
import Foundation
import MapKit

class ProjectListViewController: MyViewController {
    var isList = true
    var projectList = MainModel.projects.projectData.sort { $0.alphabetical < $1.alphabetical}
    var locationEnabled : Bool = false
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var map: UIView!
    @IBOutlet weak var mapListSegmented: UISegmentedControl!

    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isList = true
            map.hidden = true
            table.hidden = false
            //mapListButton.setBackgroundImage(UIImage(named: "list_light"), forState: UIControlState.Normal)
        } else {
            isList = false
            map.hidden = false
            table.hidden = true
            //mapListButton.setBackgroundImage(UIImage(named: "map_light"), forState: UIControlState.Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifiers.mapVC) as! MapViewController
        vc.displayData = [(ThemeColors.lightMapBlue, projectList)]
        map.addSubview(vc.view)
        self.addChildViewController(vc)
        map.layoutIfNeeded()
        vc.view.frame = map.bounds
        map.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refresh), name: GlobalNotificationKeys.locationUpdate, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        self.table.reloadData()
    }
}


//MARK: TableView functions
extension ProjectListViewController {
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return projectList.count
    }
    
    
    func tableView(tableView: UITableView!,
                   cellForRowAtIndexPath indexPath: NSIndexPath!) -> ProjectTableViewCell!
    {
        let cell = self.table.dequeueReusableCellWithIdentifier("projectCell") as! ProjectTableViewCell
        let proj = projectList[indexPath.row]
        cell.titleLabel.text = proj.title
        cell.locationEnabled = self.locationEnabled
        if let dist = proj.distanceToUser {
            cell.distanceLabel.text = dist.toDistanceString()
        } else {
            cell.distanceLabel.text = ""
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let image = ImageUtil.imageFromURL(proj.imageLink)
            dispatch_async(dispatch_get_main_queue()){
                cell.backgroundImage.image = image
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        let proj = projectList[row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("projectViewController") as! ProjectViewController
        vc.project = proj
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}

//
//  MapViewController.swift
//  West Campus
//
//  Created by jared weinstein on 11/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//



import UIKit
import Foundation

class ProjectListViewController: MyViewController {
    var isList = true
    var projectList = MainModel.projects.projectData
    var locationEnabled : Bool = false
    @IBOutlet weak var mapListButton: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var map: UIView!
    
    @IBAction func mapListTogglePressed(sender: AnyObject) {
        if isList {
            isList = false
            map.hidden = false
            table.hidden = true
            mapListButton.setBackgroundImage(UIImage(named: "list_light"), forState: UIControlState.Normal)
        }else{
            isList = true
            map.hidden = true
            table.hidden = false
            mapListButton.setBackgroundImage(UIImage(named: "map_light"), forState: UIControlState.Normal)
        }
        
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(vcIdentifiers.mapVC) as! MapViewController
        vc.projectsToBeDisplayed = projectList
        map.addSubview(vc.view)
        self.addChildViewController(vc)
        map.layoutIfNeeded()
        vc.view.frame = map.bounds
        map.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.distanceLabel.text = String(proj.radius)
        cell.backgroundImage.image = ImageUtil.imageFromURL(proj.imageLink)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        let proj = MainModel.projects.projectData[row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("projectViewController") as! ProjectViewController
        vc.project = proj
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath: NSIndexPath) -> CGFloat {
        return 100
    }
}

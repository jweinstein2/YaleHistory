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
    var projectList = MyViewController.model.projects.projectData
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
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return projectList.count
    }
    
    
    func tableView(tableView: UITableView!,
        cellForRowAtIndexPath indexPath: NSIndexPath!) -> ProjectTableViewCell!
    {
        let cell:ProjectTableViewCell = ProjectTableViewCell(style:UITableViewCellStyle.Default, reuseIdentifier:"projectCell")
        cell.textLabel?.text = projectList[indexPath.row].title
        cell.locationEnabled = self.locationEnabled
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        let proj = MyViewController.model.projects.projectData[row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("projectViewController") as! ProjectViewController
        vc.project = proj
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("mapViewController") as! MapViewController
        vc.projectsToBeDisplayed = projectList
        map.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.view.frame = CGRectMake(10, 10, map.frame.size.width - 20, map.frame.size.height - 20) // THIS NEEDS TO BE CHANGED TO DISPLAY THE MAP CORRECTLY IN THE FRAME
        //map.bringSubviewToFront(vc.view)
        map.hidden = true
        // Do any additional setup after loading the view, typically from a nib.   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


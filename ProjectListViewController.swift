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
        self.dismissViewControllerAnimated(false, completion: nil);
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
        
        //Need to make this dynamically update
        cell.distanceLabel.text = NSString(format: "%.2fm", projectList[indexPath.row].distanceToUser!) as String
        if projectList[indexPath.row].distanceToUser < 10{
            cell.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 0.15)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        MyViewController.model.currentProject = row
        self.performSegueWithIdentifier("listToProject", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("mapViewController") as! MapViewController
        vc.projectsToBeDisplayed = projectList
        map.addSubview(vc.view)
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


//
//  SHWelcomeViewController.swift
//  West Campus
//
//  Created by Tom Chu on 12/3/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit
import MapKit

class SHWelcomeViewController: MyViewController {
    var currentlySelectedIndex = 0
    var possibleTours : [(description: String, hunt: ScavengerHunt)] = []
    var currentHunt : ScavengerHunt {
        return possibleTours[currentlySelectedIndex].hunt
    }
    
    let basicTourCount = 5 //Add these two properties to the tourData variable
    let fullTourCount = 14
    
    @IBOutlet weak var announcement: UILabel!
    @IBOutlet weak var tourDescription: UILabel!
    @IBOutlet weak var tourOptionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var destinationTable : UITableView!
    @IBOutlet weak var timeEstimateLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        let shortScavenger = ScavengerHunt(destinations: MainModel.projects.nearestProjects(num: basicTourCount) ?? [])
        shortScavenger.delegate = self
        possibleTours.append(("Take a quick tour of the five nearest points of interest", shortScavenger))
        let fullScavenger = ScavengerHunt(destinations: MainModel.projects.nearestProjects(num: fullTourCount) ?? [])
        fullScavenger.delegate = self
        possibleTours.append(("Embark on a full tour of all fourteen colleges and the histories behind their names", fullScavenger))
        
        updateViewForSegment(currentlySelectedIndex)
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    @IBAction func onTourTypeChanged(sender: UISegmentedControl) {
        currentlySelectedIndex = sender.selectedSegmentIndex
        updateViewForSegment(currentlySelectedIndex)
    }
    
    private func updateViewForSegment(n: Int) {
        tourDescription.text = possibleTours[n].description
        destinationTable.reloadData()
        updateTimeEstimate()
    }
    
    @IBAction func nextbuttonPressed(sender: AnyObject) {
        if (currentHunt.projects.count == 0) { //if they selected no projects, send error
            //announcement.text = "Sorry, please select at least one tag to move forward"
        }
        else {
            //Set up scavenger hunt and transition appropriately
            MainModel.hunt = currentHunt
            
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("scavengerHuntViewController") as! ScavengerHuntViewController
            
            var vcs = self.navigationController!.viewControllers
            vcs.removeLast()
            vcs.append(vc)
            self.navigationController?.setViewControllers(vcs, animated: true)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        for scavenger in possibleTours {
            scavenger.hunt.delegate = nil
        }
    }
}

extension SHWelcomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scavengerHuntListCell")!
        let project = self.currentHunt.projects[indexPath.row]
        cell.textLabel?.text = project.title
        //cell.detailTextLabel?.text = project.summary
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentHunt.projects.count
    }
}

extension SHWelcomeViewController : ScavengerHuntDelegate {
    func onTimeEstimateChanged(timeEstimate: NSTimeInterval) {
        updateTimeEstimate()
    }
    
    func onDirectionsFailed() {
        
    }
    
    private func updateTimeEstimate(){
        
        let timeString = currentHunt.timeEstimateString
        timeEstimateLabel.text = "Estimated Time: \(timeString)"
    }
}

//
//  NoteListVC.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.
//  Copyright © 2024 Aaryan Kothari. All rights reserved.
//

import UIKit
import CoreData

class NoteListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: -------- OUTLETS & VARIABLES --------
    
    /// `Tableview` to display list of tasks
    @IBOutlet weak var noteTableView: UITableView!
    
    @IBOutlet weak var createNewButton: UIButton!
    
    var userdata: [coreData] = []
    
    
     
    var searchController: UISearchController!
    
    /// `ResultsController` to display results of specific search
    var resultsTableController: ResultsTableController!
    
    /// `DataSource` for todoTableview
   // var todoList : [Task] = []
    
    /// last task tapped!
    var lastIndexTapped : Int = 0
    
    /// Coredata managed object
    var moc: NSManagedObjectContext!

    /// Controller to fetch tasks from core-data
    var fetchedResultsController: NSFetchedResultsController<Task>!
    
    /// default fetch request for tasks
    lazy var defaultFetchRequest: NSFetchRequest<Task> = {
        let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
        return fetchRequest
    }()
    
    /// default sort is `Alphabetical ascending`
    var currentSelectedSortType: SortTypesAvailable = .sortByNameAsc
    
    var hapticNotificationGenerator: UINotificationFeedbackGenerator? = nil
    
    //MARK: -------- View lifecycle methods --------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //showOnboardingIfNeeded() /// present onboarding screen for first time
       // setupEmptyState() /// show emppty view if no tasks present
        loadData() /// Core data setup and population
        setupSearchController() /// setup search view controller for searching
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.searchController = searchController
        self.noteTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.noteTableView.reloadData()
    }
    

    
    /// initialize ManagedObjectContext
    func loadData() {
        
        userdata =  CoreDataLogic.retrieveData()
        
        for item in userdata{
            print(item)
        }
        
        
        DispatchQueue.main.async {
            self.noteTableView.reloadData()
        }
        
//        
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let persistenceContainer = appDelegate.persistentContainer
//        moc = persistenceContainer.viewContext
//        defaultFetchRequest.sortDescriptors = currentSelectedSortType.getSortDescriptor()
//        defaultFetchRequest.predicate = NSPredicate(format: "isComplete = %d", false)
//        setupFetchedResultsController(fetchRequest: defaultFetchRequest)
//        /// reloading the table view with the fetched objects
//        if let objects = fetchedResultsController.fetchedObjects {
//            self.todoList = objects
//            
//        }
    }
    
    /// initialize FetchedResultsController
    func setupFetchedResultsController(fetchRequest: NSFetchRequest<Task>) {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    //MARK: -------- IBActions --------
    /// perform segue to `TaskDetailsViewController` if `+` tapped
    @IBAction func addNewNotes(_ sender: Any) {
        //performSegue(withIdentifier: Constants.Segue.createNewNotes, sender: false)
        
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TaskDetailsViewController") as? TaskDetailsViewController {
            navigationController?.pushViewController(destinationVC, animated: true)
        }
        
        
    }
    @IBAction func addTasksTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.Segue.taskToTaskDetail, sender: false)
    }
    
    @IBAction func sortButtonTapped(_ sender: UIBarButtonItem) {
        showSortAlertController()
    }
    
    //MARK: -------- STAR - DELETE - COMPLETE - UPDATE --------
    
    /// function called when `Star Task` tapped
    /// - Parameter index: Which task to  star
    func starTask(at index : Int){
//        todoList[index].isFavourite = todoList[index].isFavourite ? false : true
//        updateTask()
    }
    
    /// function called when `Delete Task` tapped
    /// - Parameter index: Which task to  delete
    func deleteTask(at index : Int){
//        hapticNotificationGenerator = UINotificationFeedbackGenerator()
//        hapticNotificationGenerator?.prepare()
//        
//        let element = todoList.remove(at: index) /// removes task at index
//        moc.delete(element) /// deleting the object from core data
//        do {
//            try moc.save()
//            hapticNotificationGenerator?.notificationOccurred(.success)
//        } catch {
//            todoList.insert(element, at: index)
//            print(error.localizedDescription)
//            hapticNotificationGenerator?.notificationOccurred(.error)
//        }
//        noteTableView.reloadData() /// Reload tableview with remaining data
//        hapticNotificationGenerator = nil
    }
    
    /// Mark a task as complete and remove from the `tableView`
    /// - Parameter index: Which task to mark as complete
    func completeTask(at index : Int){
//        todoList[index].isComplete = true
//        todoList.remove(at: index) /// removes task at index
//        updateTask()
//        noteTableView.reloadData()
    }
    
    /// Update task
    /// function called whenever updating a task is required
    func updateTask(){
//        hapticNotificationGenerator = UINotificationFeedbackGenerator()
//        hapticNotificationGenerator?.prepare()
//        
//        do {
//            try moc.save()
//            hapticNotificationGenerator?.notificationOccurred(.success)
//        } catch {
//            print(error.localizedDescription)
//            hapticNotificationGenerator?.notificationOccurred(.error)
//        }
//        loadData()
//        hapticNotificationGenerator = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let taskDetailVC = segue.destination as? TaskDetailsViewController {
            // Hide the tab bar when new controller is pushed onto the screen
            taskDetailVC.hidesBottomBarWhenPushed = true
            taskDetailVC.delegate = self
            taskDetailVC.task = sender as? Task
        }
    }
    
//    /// onboarding setup
//    fileprivate func showOnboardingIfNeeded() {
//        guard let onboardingController = self.storyboard?.instantiateViewController(identifier: Constants.ViewController.Onboarding) as? OnboardingViewController else { return }
//        
//        if !onboardingController.alreadyShown() {
//            DispatchQueue.main.async {
//                self.present(onboardingController, animated: true)
//            }
//        }
//    }
    
    /// search controller setup
    fileprivate func setupSearchController() {
        resultsTableController =
            self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewController.ResultsTable) as? ResultsTableController
        resultsTableController.tableView.delegate = self
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.view.backgroundColor = .white
    }
    
    fileprivate func setupEmptyState() {
        let emptyBackgroundView = EmptyState(.emptyList)
        noteTableView.backgroundView = emptyBackgroundView
        noteTableView.setNeedsLayout()
        noteTableView.layoutIfNeeded()
    }
    
    //MARK:  ------ Tableview Datasource methods ------
    
    
    
    /// function to determine `Number of rows` in tableview
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // self.sortButton.isEnabled = self.todoList.count > 0
        
        if userdata.isEmpty {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
            
        }
        
        return userdata.count
    }
 
    
    /// function  to determine `tableview cell` at a given row
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.taskCell, for: indexPath) as! TaskCell
        let task = userdata[indexPath.row]
        cell.title.text = task.title
        cell.subtitle.text = task.details
       // cell.starImage.isHidden = todoList[indexPath.row].isFavourite ? false : true
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastIndexTapped = indexPath.row
        let task = userdata[indexPath.row]
        
         if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TaskDetailsViewController") as? TaskDetailsViewController {
             destinationVC.userdata = task
             destinationVC.update = true
             navigationController?.pushViewController(destinationVC, animated: true)
         }
         
         
       // performSegue(withIdentifier: Constants.Segue.taskToTaskDetail, sender: task)
    }
    
    
    //MARK:  ----- Tableview Delagate methods  ------
    
    /// `UISwipeActionsConfiguration` for delete and star  buttons
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actions = Constants.Action.self
        
        // DELETE ACTION
        let delete = UIContextualAction(style: .destructive, title: actions.delete) { _,_,_ in
            self.deleteTask(at: indexPath.row)
        }
        
        // STAR ACTION
        let star = UIContextualAction(style: .normal, title: .empty) { _,_,_ in
            self.starTask(at: indexPath.row)
        }
        star.backgroundColor = .orange
       //star.title = todoList[indexPath.row].isFavourite ? actions.unstar : actions.star
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete,star])
        return swipeActions
    }
    
    /// `UISwipeActionsConfiguration` for completing a task
     func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeTask = UIContextualAction(style: .normal, title: .empty) {  (_, _, _) in
            self.completeTask(at: indexPath.row)
        }
        completeTask.backgroundColor = .systemGreen
        completeTask.title = Constants.Action.complete
        let swipeActions = UISwipeActionsConfiguration(actions: [completeTask])
        
        return swipeActions
    }
    
    /// function to determine `View for Footer` in tableview.
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView() /// Returns an empty view.
    }
}

extension NoteListVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        noteTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        noteTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            noteTableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            noteTableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            noteTableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            break
        @unknown default:
            break
        }
    }
}

//MARK: - TaskDelegate
/// protocol for `saving` or `updating` `Tasks`
extension NoteListVC : TaskDelegate{
    func didTapSave(task: Task) {
//        userdata.append(task)
//        do {
//            try moc.save()
//        } catch {
//            todoList.removeLast()
//            print(error.localizedDescription)
//        }
        loadData()
    }
    
    func didTapUpdate(task: Task) {
        /// Reload tableview with new data
        updateTask()
    }
    
    
}

// MARK: - Search Bar Delegate

extension NoteListVC: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        /// perform search only when there is some text
        if let text: String = searchController.searchBar.text?.lowercased(), text.count > 0, let resultsController = searchController.searchResultsController as? ResultsTableController {
//            resultsController.todoList = todoList.filter({ (task) -> Bool in
//                if task.title?.lowercased().contains(text) == true || task.subTasks?.lowercased().contains(text) == true {
//                    return true
//                }
//                return false
//            })
            let fetchRequest : NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            fetchRequest.predicate = NSPredicate(format: "title contains[c] %@", text)
            setupFetchedResultsController(fetchRequest: fetchRequest)
            resultsController.tableView.reloadData()
        } else {
            /// default case when text not available or text length is zero
            noteTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        noteTableView.reloadData()
    }
}

// MARK:- Sort functionality
extension NoteListVC {
    
    func showSortAlertController() {
        let alertController = UIAlertController(title: nil, message: "Choose sort type", preferredStyle: .actionSheet)
        
        SortTypesAvailable.allCases.forEach { (sortType) in
            let action = UIAlertAction(title: sortType.getTitleForSortType(), style: .default) { (_) in
                self.currentSelectedSortType = sortType
                self.loadData()
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: Constants.Action.cancel, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }
}


//
//  TaskDetailsViewController.swift
//  To-Do
//
//  Created by Sabbir Ahmed on 14/3/24.
 

import UIKit
import CoreData

protocol TaskDelegate: AnyObject {
    func didTapSave(task : Task)
    func didTapUpdate(task : Task)
}

class TaskDetailsViewController: UIViewController{
    
    // OUTLETS
    @IBOutlet private weak var taskTitleTextField: UITextField!
    @IBOutlet private weak var subTasksTextView: UITextView!
    @IBOutlet private weak var endDateTextField: UITextField!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var attachmentCollection: UICollectionView!
    
    
    var userdata = coreData()
    var update = false
    
    // VARIABLES
    var task : Task? = nil
    var endDate : String = .empty
    var endDatePicker: UIDatePicker!
    var dateFormatter: DateFormatter = DateFormatter()
    weak var delegate : TaskDelegate?
    var isUpdate: Bool = false
    var selectedDateTimeStamp: Double?
    var imagesAttached = [UIImage]()
    var todoList : [Task] = []
    var moc: NSManagedObjectContext!
    var cameraHelper = CameraHelper()
    
    var hapticGenerator: UINotificationFeedbackGenerator? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if update {
            saveButton.title = "Update"
            taskTitleTextField.text = userdata.title
            subTasksTextView.text = userdata.details
        }
        
        
        isUpdate = (task != nil)
        endDatePicker = UIDatePicker()
        endDatePicker.addTarget(self, action: #selector(didPickDate(_:)), for: .valueChanged)
        endDatePicker.minimumDate = Date()
        endDateTextField.inputView = endDatePicker
        dateFormatter.dateStyle = .medium
        subTasksTextView.addBorder()
        loadTaskForUpdate()
        taskTitleTextField.delegate = self
        // Tap outside to close the keybord
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        saveButton.title = isUpdate ? Constants.Action.update : Constants.Action.add
    }
    
    @IBAction func addImageAttachment(_ sender: Any) {
        // opening camera
        cameraHelper.openCamera(in: self) { [weak self] image in
            guard let image = image else { return }
            
            // Adding attachment
            self?.imagesAttached.append(image)
            self?.attachmentCollection.reloadData()
        }
    }
    
    @IBAction func saveNotes(_ sender: Any) {
        let noteTitle = taskTitleTextField.text ?? ""
        let noteDetails = subTasksTextView.text ?? ""
        
        if noteTitle.count == 0 {
            showAlert(msg: "Please enter note title")
        }else if noteDetails.count == 0 {
            showAlert(msg: "Please enter note details")
        }
        else if  update {
            CoreDataLogic.updateData(id: userdata.id ?? "", noteTitle: userdata.title ?? "", noteDetails: userdata.details ?? "")
        }
        
        else{
            var noteCounter = UserDefaults.standard.integer(forKey: Constants.Key.noteCounter)
            noteCounter += 1
            UserDefaults.standard.set(noteCounter, forKey: Constants.Key.noteCounter)
            CoreDataLogic.createData(id: String(noteCounter), noteTitle: noteTitle, noteDetails: noteDetails)
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        hapticGenerator = UINotificationFeedbackGenerator()
        hapticGenerator?.prepare()
        
        guard isValidTask() else {
            hapticGenerator?.notificationOccurred(.warning)
            return
        }
        guard let task = createTaskBody() else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        hapticGenerator?.notificationOccurred(.success)
        
        if isUpdate {
            self.delegate?.didTapUpdate(task: task)
            
        } else {
            //self.delegate?.didTapSave(task: task)
            didTapSave(task: task)
        }
        self.navigationController?.popViewController(animated: true)
        
        hapticGenerator = nil
    }
    
    /// Function that determines if a task is valid or not. A valid task has both a title and due date.
    /// Title: String taken from `taskTitleTextField`
    /// endDate : String taken from `endDueDateTextField`
    /// - Returns: A bool whether or not the task is valid.
    func isValidTask() -> Bool {
        if taskTitleTextField.text?.trim().isEmpty ?? true {
            Alert.showNoTaskTitle(on: self)
            return false
        } else if endDateTextField.text?.trim().isEmpty ?? true {
            Alert.showNoTaskDueDate(on: self)
            return false
        } else {
            return true
        }
    }
    
    func didTapSave(task: Task) {
        todoList.append(task)
        do {
            try moc.save()
        } catch {
            todoList.removeLast()
            print(error.localizedDescription)
        }
        // loadData()
    }
    
    func showAlert(msg: String) {
        // Create the alert controller
        let alert = UIAlertController(title: "Alert!!", message: msg, preferredStyle: .alert)
        
        // Add an action to the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            // Handle the OK action
            print("OK button tapped.")
        }))
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // function that `Creates Task body`
    /// Title: String taken from `taskTitleTextField`
    /// Subtask: String taken from `subTasksTextView`
    /// endDate : String taken from `didPickDate method`
    func createTaskBody()->Task? {
        let title = taskTitleTextField.text?.trim() ?? .empty
        let subtask = subTasksTextView.text?.trim() ?? .empty
        /// check if we are updating the task or creatiing the task
        //        if self.task == nil {
        //            let mainController = self.delegate as! NoteListVC
        //            self.task = Task(context: mainController.moc)
        //        }
        task?.title = title
        task?.subTasks = subtask
        task?.dueDate = endDate
        task?.dueDateTimeStamp = selectedDateTimeStamp ?? 0
        task?.attachments = try? NSKeyedArchiver.archivedData(withRootObject: imagesAttached, requiringSecureCoding: false)
        task?.isComplete = false
        
        return task
    }
    
    func loadTaskForUpdate() {
        guard let task = self.task else {
            subTasksTextView.textColor = .placeholderText
            return
        }
        taskTitleTextField.text = task.title
        subTasksTextView.text = task.subTasks
        endDateTextField.text = task.dueDate
        
        // Recover attachments
        if let attachments = task.attachments {
            imagesAttached = NSKeyedUnarchiver.unarchiveObject(with: attachments) as? [UIImage] ?? []
        }
    }
    
    // IBOUTLET for datepicker
    /// function is called when `Date is changed`
    /// `Dateformatter` is used to convert `Date` to `String`
    @objc func didPickDate(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        let selectedDate = sender.date
        self.selectedDateTimeStamp = sender.date.timeIntervalSince1970
        endDate = dateFormatter.string(from: selectedDate)
        endDateTextField.text = endDate
    }
    
}
extension TaskDetailsViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == taskTitleTextField {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter your subtasks here"
            textView.textColor = .placeholderText
        }
    }
}

extension TaskDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesAttached.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.photoCell, for: indexPath) as! ImageAttachmentCell
        let image = imagesAttached[indexPath.row]
        
        cell.setImage(image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("Click: \(indexPath.row) \(imagesAttached[indexPath.row])")
    }
}


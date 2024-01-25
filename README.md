# To-Do App

This is a simple To-Do app built using Ruby on Rails, designed to help you manage your tasks efficiently. The app allows users to create, edit, and delete tasks, categorizing them into "To Do," "In Progress," and "Done."

# Features

- **Task Organization:** Categorize your tasks into three main sections: To Do, In Progress, and Done. This is made possible through the status attribute in the Task model, which uses an enumeration to manage these states.
- **Task Details:**  Each task includes a name, description, priority, due date, and duration. The Task model ensures task names are unique and automatically capitalizes them using a `before_save` callback, and the description is within the specified length limits.
- **User Authentication:** Secure your tasks by ensuring that only authenticated users can access and manage them.
- **Task Deletion Rules:** Tasks can only be deleted if they are marked as "Done," a rule enforced through a `before_destroy` callback in the Task model, preventing accidental deletion.
- **Overdue Marking:** Tasks are automatically marked as overdue if the due date has passed and they are still in the "To Do" and "In Progress" status, implemented via a `before_save` callback.
- **Search Functionality:** The TasksController includes functionality to filter tasks by name or description, demonstrating advanced database query capabilities
- **Turbo Frames:** In this application, Turbo Frames are utilized to create a seamless user experience when interacting with tasks. Modals for creating and editing tasks are implemented using Turbo Frames, providing a dynamic and responsive interface without the need for traditional full-page reloads.


# Technologies Used

- Ruby on Rails
- HTML
- CSS
- JavaScript
- Turbo Frames
- Bootstrap (for styling)
- Devise (for user authentication)


# Demo
Explore the app live on [Heroku](https://todolist-12-69e060ffe57a.herokuapp.com). 

user:     test@test.com

password: 123456

## Usage

### 1. Create a Task

Click on the "New Task" button. Fill in the task details and submit the form.

### 2. Edit a Task

Click on the edit icon next to a task. Update the task details and save the changes.

### 3. Delete a Task

Click on the delete button when editing a task. Confirm the deletion.

## Contributing

Contributions are welcome! If you have any suggestions, improvements, or bug fixes, feel free to open an issue or create a pull request.

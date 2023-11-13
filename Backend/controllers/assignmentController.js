const Assignment = require('../models/Assignment')

// create a new assignment
exports.createAssignment = async (req, res) => {

    const { title, description, dueDate } = req.body

    try {
        // create new assignment
        const newAssignment = new Assignment({
            title: title,
            description: description, 
            datePosted: Date(),
            dueDate: dueDate
        })

        await newAssignment.save()

        return res.status(201).json({ message: 'Assignment created successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ message: 'Internal Server Error' })
    }
}

// get assignment by id
exports.getAssignmentById = async (req, res) => {
    const assignmentId = req.params.id

    try {
        const retrievedAssignment = await Assignment.findById(assignmentId)

        if (!retrievedAssignment) {
            // 404 if assignment with assignmentId does not exist
            return res.status(404),json({ error: 'Assignment not found' })
        } else {
            // return 200 and assignment if successful
            return res.status(200).json({ message: 'Assignment retrieved successfully', retrievedAssignment})
        }
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }

}

// update assignment
exports.updateAssignment = async (req, res) => {
    const assignmentId = req.params.id
    const { title, description, dueDate} = req.body

    try {
        // find the assignment by id and update fields
        const updatedAssignment = await Assignment.findByIdAndUpdate(assignmentId, { title: title, description: description, dueDate: dueDate }, { new: true })

        if (!updatedAssignment) {
            // 404 if assignment with given id does not exist
            return res.status(404).json({ error: 'Assignment not found' })
        }

        // on success return 200 status, success message, and updated assignment
        res.status(200).json({ message: 'Assignment updated successfully', updatedAssignment })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// delete assignment
exports.deleteAssignment = async (req, res) => {
    const assignmentId = req.params.id

    try {
        // find the assignment by id and delete
        const deletedAssignment = await Assignment.findByIdAndDelete(assignmentId)

        if (!deletedAssignment) {
            // 404 if assignment with given id does not exist
            return res.status(404).json({ error: 'Assignment not found' })
        }

        res.status(200).json({ message: 'Assignment deleted successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}
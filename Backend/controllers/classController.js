const Class = require('../models/Class')
const Event = require('../models/Event')
const Assignment = require('../models/Assignment')
const Alert = require('../models/Alert')
const User = require('../models/User')

// create class
exports.createClass = async (req, res) => {

    const { className, color } = req.body

    const generateUniqueCode = () => {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        let code = '';
        for (let i = 0; i < 6; i++) {
            const randomIndex = Math.floor(Math.random() * characters.length);
            code += characters[randomIndex];
        }
        return code;
    };

    // check if generated code is unique, otherwise, regenerate code
    let code;
    do {
        code = generateUniqueCode();
    } while (await Class.findOne({ code: code }));

    try {
        // create new class
        const newClass = new Class({
            className: className,
            color: color,
            code: code
        })

        await newClass.save()

        return res.status(201).json({ message: 'Class created successfully', newClass: newClass })
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ message: 'Internal Server Error' })
    }
}

// get class by id
exports.getClassById = async (req, res) => {
    const classId = req.params.id

    try {
        const retrievedClass = await Class.findById(classId)

        if (!retrievedClass) {
            return res.status(404),json({ error: 'Class not found' })
        } else {
            return res.status(200).json({message: 'Class retrieved successfully', class: {
                _id: retrievedClass._id,
                className: retrievedClass.className, 
                color: retrievedClass.color, 
                code: retrievedClass.code, 
                events: retrievedClass.events, 
                assignments: retrievedClass.assignments,
                alerts: retrievedClass.alerts,
                studentInputs: retrievedClass.studentInputs,
                users: retrievedClass.users
            }})        }
    } catch (error) {
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }

}

// get class by class code
exports.getClassByCode = async (req, res) => {

    const { code } = req.body

    try {
        // try to find class with code from request body
        const retrievedClass = await Class.findOne({ code: code }).exec()
            
        // check if class with that code exists
        if (retrievedClass) {
            // return class if it exists
            return res.status(200).json({message: 'Class retrieved successfully', class: {
                _id: retrievedClass._id,
                className: retrievedClass.className, 
                color: retrievedClass.color, 
                code: retrievedClass.code, 
                events: retrievedClass.events, 
                assignments: retrievedClass.assignments,
                alerts: retrievedClass.alerts,
                studentInputs: retrievedClass.studentInputs,
                users: retrievedClass.users
            }})
        } else {
            // 404 if class does not exist
            return res.status(404).json({ error: 'Class not found' })
        }
    } catch (error) {
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }

    
}

// update class
exports.updateClass = async (req, res) => {
    const classId = req.params.id
    const { className, color } = req.body

    try {
        // find the class by id and update className and color
        const updatedClass = await Class.findByIdAndUpdate(classId, { className, color }, { new: true })

        if (!updatedClass) {
            // 404 if class with given id does not exist
            return res.status(404).json({ error: 'Class not found' })
        }

        // return class on success
        return res.status(200).json({message: 'Class updated successfully', class: {
            _id: retrievedClass._id,
            className: retrievedClass.className, 
            color: retrievedClass.color, 
            code: retrievedClass.code, 
            events: retrievedClass.events, 
            assignments: retrievedClass.assignments,
            alerts: retrievedClass.alerts,
            studentInputs: retrievedClass.studentInputs,
            users: retrievedClass.users
        }})    
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// add event to class
exports.addEvent = async (req, res) => {
    const classId = req.params.id
    const { eventId } = req.body

    try {
        // find the class by id
        const updatedClass = await Class.findById(classId)

        // find the event by id
        const addedEvent = await Event.findById(eventId)

        if (!updatedClass) {
            // 404 if class with given id does not exist
            return res.status(404).json({ error: 'Class not found' })
        }

        if (!addedEvent) {
            // 404 if event with given id does not exist
            return res.status(404).json({ error: 'Event not found' })
        }

        // add event to class.events and save
        updatedClass.events.push(addedEvent)
        await updatedClass.save()

        // create notification for this event

        // return class on success
        return res.status(200).json({message: 'Event added to class successfully', class: {
            _id: retrievedClass._id,
            className: retrievedClass.className, 
            color: retrievedClass.color, 
            code: retrievedClass.code, 
            events: retrievedClass.events, 
            assignments: retrievedClass.assignments,
            alerts: retrievedClass.alerts,
            studentInputs: retrievedClass.studentInputs,
            users: retrievedClass.users
        }})    
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// add assignment to class
exports.addAssignment = async (req, res) => {
    const classId = req.params.id
    const { assignmentId } = req.body

    try {
        // find the class by id
        const updatedClass = await Class.findById(classId)

        // find the assignment by id
        const addedAssignment = await Event.findById(assignmentId)

        if (!updatedClass) {
            // 404 if class with given id does not exist
            return res.status(404).json({ error: 'Class not found' })
        }

        if (!addedAssignment) {
            // 404 if assignment with given id does not exist
            return res.status(404).json({ error: 'Event not found' })
        }

        // add assignment to class.assignments and save
        updatedClass.assignments.push(addedAssignment)
        await updatedClass.save()

        // create a notification for this assignment

        // return class on success
        return res.status(200).json({message: 'Assignment added to class successfully', class: {
            _id: retrievedClass._id,
            className: retrievedClass.className, 
            color: retrievedClass.color, 
            code: retrievedClass.code, 
            events: retrievedClass.events, 
            assignments: retrievedClass.assignments,
            alerts: retrievedClass.alerts,
            studentInputs: retrievedClass.studentInputs,
            users: retrievedClass.users
        }})    
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// add alert to class
exports.addAlert = async (req, res) => {
    const classId = req.params.id
    const { alertId } = req.body

    try {
        // find the class by id
        const updatedClass = await Class.findById(classId)

        // find the alert by id
        const addedAlert = await Alert.findById(alertId)

        if (!updatedClass) {
            // 404 if class with given id does not exist
            return res.status(404).json({ error: 'Class not found' })
        }

        if (!addedAlert) {
            // 404 if alert with given id does not exist
            return res.status(404).json({ error: 'Alert not found' })
        }

        // add alert to class.alerts and save
        updatedClass.alerts.push(addedAlert)
        await updatedClass.save()

        // create notificaiton for this alert

        // return class on success
        return res.status(200).json({message: 'Alert added to class successfully', class: {
            _id: retrievedClass._id,
            className: retrievedClass.className, 
            color: retrievedClass.color, 
            code: retrievedClass.code, 
            events: retrievedClass.events, 
            assignments: retrievedClass.assignments,
            alerts: retrievedClass.alerts,
            studentInputs: retrievedClass.studentInputs,
            users: retrievedClass.users
        }})    
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// add a user to class
exports.addUser = async (req, res) => {
    const classId = req.params.id
    const { userId } = req.body

    try {
        // find the class by id
        const updatedClass = await Class.findById(classId)

        // find the user by id
        const addedUser = await User.findById(userId)

        if (!updatedClass) {
            // 404 if class with given id does not exist
            return res.status(404).json({ error: 'Class not found' })
        }

        if (!addedUser) {
            // 404 if user with given id does not exist
            return res.status(404).json({ error: 'User not found' })
        }

        // add alert to class.alerts and save
        updatedClass.users.push(addedUser)
        addedUser.classes.push(updatedClass)
        await updatedClass.save()

        // return class on success
        return res.status(200).json({message: 'User added to class successfully', class: {
            _id: updatedClass._id,
            className: updatedClass.className, 
            color: updatedClass.color, 
            code: updatedClass.code, 
            events: updatedClass.events, 
            assignments: updatedClass.assignments,
            alerts: updatedClass.alerts,
            studentInputs: updatedClass.studentInputs,
            users: updatedClass.users
        }})    
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// delete class
exports.deleteClass = async (req, res) => {
    const classId = req.params.id

    try {
        // find the class by id and delete
        const deletedClass = await Class.findByIdAndDelete(classId)

        if (!deletedClass) {
            // 404 if class with given id does not exist
            return res.status(404).json({ error: 'Class not found' })
        }

        res.status(200).json({ message: 'Class deleted successfully' })
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}
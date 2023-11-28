const User = require('../models/User')
const Class = require('../models/Class')

// get user by id
exports.getUserById = async(req, res) => {
    const userId = req.params.id
    
    try {
        // find user by id
        const retrievedUser = await User.findById(userId)

        if (!retrievedUser) {
            // 404 if user cannot be found
            return res.status(404).json({ error: 'User not found' })
        }

        // return success status and message along with retrieved user
        res.status(200).json({ message: 'User retrieved successfully',
            _id: retrievedUser._id,
            email: retrievedUser.email,
            role: retrievedUser.role,
            schedule: retrievedUser.schedule,
            classes: retrievedUser.classes,
            notifications: retrievedUser.notifications
        })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

exports.deleteUser = async (req, res) => {
    const userId = req.params.id
    
    try {
        // find user by id then delete
        const deletedUser = await User.findByIdAndDelete(userId)

        if (!deletedUser) {
            // 404 if user cannot be found
            return res.status(404).json({ error: 'User not found' })
        }

        // return success status and message
        res.status(200).json({ error: 'User deleted successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// set user's schedule, either for the first time or to update
exports.setSchedule = async (req, res) => {
    const userId = req.params.id
    const { scheduleId } = req.body

    try {
        // find the user by id and set schedule a
        const updatedUser = await User.findByIdAndUpdate(userId, { schedule: scheduleId })

        if (!updatedUser) {
            // 404 if user cannot be found
            return res.status(404).json({ error: 'User not found' })
        }

        // return success status and message along with updated user
        res.status(200).json({ message: 'Schedule set successfully',
            _id: updatedUser._id,
            email: updatedUser.email,
            schedule: updatedUser.schedule,
            classes: updatedUser.classes,
            notifications: updatedUser.notifications
        })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// add a class to user.classes
exports.addClass = async (req, res) => {
    const userId = req.params.id
    const { classId } = req.body

    try {
        // find user by id
        const updatedUser = await User.findById(userId)

        if (updatedUser) {
            const retrievedClass = await Class.findById(classId)
            updatedUser.classes.push(retrievedClass)
        } else {
            // 404 if user cannot be found
            return res.status(404).json({ error: 'User not found' })
        }

        // return success status and message along with upated user
        res.status(200).json({ message: 'Class added successfully',
            _id: updatedUser._id,
            email: updatedUser.email,
            schedule: updatedUser.schedule,
            classes: updatedUser.classes,
            notifications: updatedUser.notifications
        })    
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// add a notification to user.notifications
exports.addNotification = async (req, res) => {
    const userId = req.params.id
    const { notificationId } = req.body

    try {
        // find user by id 
        const updatedUser = await User.findById(userId)

        if (updatedUser) {
            updatedUser.notifications.push(notificationId)
        } else {
            // 404 if user cannot be found
            return res.status(404).json({ error: 'User not found' })
        }

        // return success status and message
        res.status(200).json({ message: 'Notification added successfully'})
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}
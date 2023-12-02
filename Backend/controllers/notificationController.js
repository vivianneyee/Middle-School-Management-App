const Notification = require('../models/Notification')

// create a new notification
exports.createNotification = async (req, res) => {

    const { className, title } = req.body

    try {
        // create new notification
        const newNotification = new Notification({
            className: className,
            title: title, 
            datePosted: Date()
        })

        await newNotification.save()

        return res.status(201).json({ message: 'Notification created successfully', notification: {
            _id: newNotification._id,
            className: newNotification.className,
            title: newNotification.title,
            datePosted: newNotification.datePosted
        }
        })
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ message: 'Internal Server Error' })
    }
}

// get notification by id
exports.getNotificationById = async (req, res) => {
    const notificationId = req.params.id

    try {
        const retrievedNotification = await Notification.findById(notificationId)

        if (!retrievedNotification) {
            // 404 if notification with notificationId does not exist
            return res.status(404),json({ error: 'Notification not found' })
        } else {
            // return 200 and noitification if successful
            return res.status(200).json({ message: 'Notification retrieved successfully', notification : {
                _id: retrievedNotification._id,
                className: retrievedNotification.className,
                title: retrievedNotification.title,
                datePosted: retrievedNotification.datePosted }
            })
        }
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }

}

// delete notification
exports.deleteNotification = async (req, res) => {
    const notificationId = req.params.id

    try {
        // find the notification by id and delete
        const deletedNotification = await Notification.findByIdAndDelete(notificationId)

        if (!deletedNotification) {
            // 404 if notification with given id does not exist
            return res.status(404).json({ error: 'Notification not found' })
        }

        res.status(200).json({ message: 'Notification deleted successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}
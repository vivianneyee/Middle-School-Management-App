const Alert = require('../models/Alert')

// create a new alert
exports.createAlert = async (req, res) => {

    const { title, description, priority } = req.body

    try {
        // create new alert
        const newAlert = new Alert({
            title: title,
            description: description, 
            datePosted: Date(),
            priority: priority
        })

        await newAlert.save()

        return res.status(201).json({ message: 'Alert created successfully', alert: {
            _id: newAlert._id,
            title: newAlert.title,
            description: newAlert.description,
            datePosted: newAlert.datePosted,
            priority: newAlert.priority }
        })
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ message: 'Internal Server Error' })
    }
}

// get alert by id
exports.getAlertById = async (req, res) => {
    const alertId = req.params.id

    try {
        const retrievedAlert = await Alert.findById(alertId)

        if (!retrievedAlert) {
            // 404 if alert with alertId does not exist
            return res.status(404),json({ error: 'Alert not found' })
        } else {
            // return 200 and alert if successful
            return res.status(200).json({ message: 'Alert retrieved successfully', alert: {
                _id: retrievedAlert._id,
                title: retrievedAlert.title,
                description: retrievedAlert.description,
                datePosted: retrievedAlert.datePosted,
                priority: retrievedAlert.priority }
            })
        }
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }

}

// update alert
exports.updateAlert = async (req, res) => {
    const alertId = req.params.id
    const { title, description, priority} = req.body

    try {
        // find the alert by id and update fields
        const updatedAlert = await Alert.findByIdAndUpdate(alertId, { title: title, description: description, priority: priority }, { new: true })

        if (!updatedAlert) {
            // 404 if alert with given id does not exist
            return res.status(404).json({ error: 'Alert not found' })
        }

        // on success return 200 status, success message, and updated alert
        res.status(200).json({ message: 'Alert updated successfully', alert: {
            _id: updatedAlert._id,
            title: updatedAlert.title,
            description: updatedAlert.description,
            datePosted: updatedAlert.datePosted,
            priority: updatedAlert.priority }
        })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// delete alert
exports.deleteAlert = async (req, res) => {
    const alertId = req.params.id

    try {
        // find the alert by id and delete
        const deletedAlert = await Alert.findByIdAndDelete(alertId)

        if (!deletedAlert) {
            // 404 if alert with given id does not exist
            return res.status(404).json({ error: 'Alert not found' })
        }

        res.status(200).json({ message: 'Alert deleted successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}
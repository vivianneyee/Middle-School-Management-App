const Event = require('../models/Event')

// create a new event
exports.createEvent = async (req, res) => {

    const { title, description, startDate, endDate } = req.body

    try {
        // create new event
        const newEvent = new Event({
            title: title,
            description: description, 
            datePosted: Date(),
            startDate: startDate,
            endDate: endDate
        })

        await newEvent.save()

        return res.status(201).json({ message: 'Event created successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ message: 'Internal Server Error' })
    }
}

// get event by id
exports.getEventById = async (req, res) => {
    const eventId = req.params.id

    try {
        const retrievedEvent = await Event.findById(eventId)

        if (!retrievedEvent) {
            // 404 if event with eventId does not exist
            return res.status(404),json({ error: 'Event not found' })
        } else {
            // return 200 and event if successful
            return res.status(200).json({ message: 'Event retrieved successfully', 
                _id: retrievedEvent._id,
                title: retrievedEvent.title,
                datePosted: retrievedEvent.datePosted,
                startDate: retrievedEvent.startDate,
                endDate: retrievedEvent.endDate
            })
        }
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }

}

// update event
exports.updateEvent = async (req, res) => {
    const eventId = req.params.id
    const { title, description, startDate, endDate} = req.body

    try {
        // find the event by id and update fields
        const updatedEvent = await Event.findByIdAndUpdate(eventId, { title: title, description: description, startDate: startDate, endDate: endDate }, { new: true })

        if (!updatedEvent) {
            // 404 if event with given id does not exist
            return res.status(404).json({ error: 'Event not found' })
        }

        // on success return 200 status, success message, and updated event
        return res.status(200).json({ message: 'Event retrieved successfully', 
            _id: retrievedEvent._id,
            title: retrievedEvent.title,
            datePosted: retrievedEvent.datePosted,
            startDate: retrievedEvent.startDate,
            endDate: retrievedEvent.endDate
        })    
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// delete event
exports.deleteEvent = async (req, res) => {
    const eventId = req.params.id

    try {
        // find the event by id and delete
        const deletedEvent = await Event.findByIdAndDelete(eventId)

        if (!deletedEvent) {
            // 404 if event with given id does not exist
            return res.status(404).json({ error: 'Event not found' })
        }

        res.status(200).json({ message: 'Event deleted successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}
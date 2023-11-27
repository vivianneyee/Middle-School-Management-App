const Schedule = require('../models/Schedule')

// create a new schedule
exports.createSchedule = async (req, res) => {

    const { day1, day2, day3, day4, day5, day6, day7, day8, day9, day10 } = req.body

    try {
        // create new schedule
        const newSchedule = new Schedule({
            day1: day1,
            day2: day2,
            day3: day3,
            day4: day4,
            day5: day5,
            day6: day6,
            day7: day7,
            day8: day8,
            day9: day9,
            day10: day10
        })

        await newSchedule.save()

        return res.status(201).json({ message: 'Schedule created successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ message: 'Internal Server Error' })
    }
}

// get schedule by id
exports.getScheduleById = async (req, res) => {
    const scheduleId = req.params.id

    try {
        const retrievedSchedule = await Schedule.findById(scheduleId)

        if (!retrievedSchedule) {
            return res.status(404),json({ error: 'Schedule not found' })
        } else {
            return res.status(200).json({ message: 'Schedule retrieved successfully', 
                _id: retrievedSchedule._id,
                day1: retrievedSchedule.day1,
                day2: retrievedSchedule.day2,
                day3: retrievedSchedule.day3,
                day4: retrievedSchedule.day4,
                day5: retrievedSchedule.day5,
                day6: retrievedSchedule.day6,
                day7: retrievedSchedule.day7,
                day8: retrievedSchedule.day8,
                day9: retrievedSchedule.day9,
                day10: retrievedSchedule.day10
            })
        }
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }
}

// update schedule
exports.updateSchedule = async (req, res) => {
    const scheduleId = req.params.id
    const { day1, day2, day3, day4, day5, day6, day7, day8, day9, day10 } = req.body

    try {
        // find the schedule by id and update schedules for each day that are changed otherwise update with original data
        const updateSchedule = await Schedule.findByIdAndUpdate(scheduleId, { day1, day2, day3, day4, day5, day6, day7, day8, day9, day10 }, { new: true })

        if (!updateSchedule) {
            // 404 if schedule with given id does not exist
            return res.status(404).json({ error: 'Schedule not found' })
        }

        return res.status(200).json({ message: 'Schedule updated successfully', 
            _id: retrievedSchedule._id,
            day1: retrievedSchedule.day1,
            day2: retrievedSchedule.day2,
            day3: retrievedSchedule.day3,
            day4: retrievedSchedule.day4,
            day5: retrievedSchedule.day5,
            day6: retrievedSchedule.day6,
            day7: retrievedSchedule.day7,
            day8: retrievedSchedule.day8,
            day9: retrievedSchedule.day9,
            day10: retrievedSchedule.day10
        })
    } catch (error) {
        // catch server error 
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// delete schedule
exports.deleteSchedule = async (req, res) => {
    const scheduleId = req.params.id

    try {
        // find the schedule by id and delete
        const deletedSchedule = await Schedule.findByIdAndDelete(scheduleId)

        if (!deletedSchedule) {
            // 404 if schedule with given id does not exist
            return res.status(404).json({ error: 'Schedule not found' })
        }

        res.status(200).json({ message: 'Schedule deleted successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

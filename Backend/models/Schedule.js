const mongoose = require('mongoose')

const scheduleSchema = new mongoose.Schema({
    day1: [{
        type: String
    }],
    day2: [{
        type: String
    }],
    day3: [{
        type: String
    }],
    day4: [{
        type: String
    }],
    day5: [{
        type: String
    }],
    day6: [{
        type: String
    }],
    day7: [{
        type: String
    }],
    day8: [{
        type: String
    }],
    day9: [{
        type: String
    }],
    day10: [{
        type: String
    }]
})

const Schedule = mongoose.model('Schedule', scheduleSchema)

module.exports = Schedule
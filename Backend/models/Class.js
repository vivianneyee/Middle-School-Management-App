const mongoose = require('mongoose')

const classSchema = new mongoose.Schema({
    className: {
        type: String,
        required: true
    },
    color: {
        type: String,
        required: true
    },
    code: {
        type: String,
        required: true
    },
    events: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Event'
    }],
    assignments: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Assignment'
    }],
    alerts: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Alert'
    }],
    studentInputs: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'StudentInput'
    }],
    users: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }]
})

const Class = mongoose.model('Class', classSchema)

module.exports = Class
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
        type: mongoose.Schema.Types.ObjectId
    }],
    assignments: [{
        type: mongoose.Schema.Types.ObjectId
    }],
    alerts: [{
        type: mongoose.Schema.Types.ObjectId
    }],
    studentInputs: [{
        type: mongoose.Schema.Types.ObjectId
    }]
})

const Class = mongoose.model('Class', classSchema)

module.exports = Schedule
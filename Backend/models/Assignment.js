const mongoose = require('mongoose')

const assignmentSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
    },
    datePosted: {
        type: Date,
        required: true
    },
    dueDate: {
        type: Date,
        required: true
    }
})

const Assignment = mongoose.model('Assignment', assignmentSchema)

module.exports = Assignment
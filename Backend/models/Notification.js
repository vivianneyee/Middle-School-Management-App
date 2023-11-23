const mongoose = require('mongoose')

const notificationSchema = new mongoose.Schema({
    className: {
        type: String,
        required: true
    },
    title: {
        type: String,
    },
    datePosted: {
        type: Date,
        required: true
    }
})

const Notification = mongoose.model('Notification', notificationSchema)

module.exports = Notification
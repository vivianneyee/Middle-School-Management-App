const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    // id: {
    //     type: mongoose.Schema.Types.ObjectId,
    //     required: true,
    //     unique: true
    // },
    email: {
        type: String,
        required: true,
        unique: true
    },
    hashedPassword: {
        type: String,
        required: true
    },
    role: {
        type: String,
        required: true
    },
    classes: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Class' // ref to class model
    }],
    schedule: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Schedule' // ref to schedule model
    },
    notifications: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Notification' // ref to notification model
    }
})

userSchema.index({ email: 1 });
const User = mongoose.model('User', userSchema)

module.exports = User
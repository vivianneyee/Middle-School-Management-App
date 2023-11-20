const express = require('express')
const app = express()

// import routes
const authRoutes = require('./routes/authRoutes')
const classRoutes = require('./routes/classRoutes')
const scheduleRoutes = require('./routes/scheduleRoutes')
const userRoutes = require('./routes/userRoutes')
const notificationRoutes = require('./routes/notificationRoutes')
const eventRoutes = require('./routes/eventRoutes')
const alertRoutes = require('./routes/alertRoutes')
const assignmentRoutes = require('./routes/assignmentRoutes')

const { ServerApiVersion } = require('mongodb')
const mongoose = require('mongoose')
const bodyParser = require('body-parser')

const uri = 'mongodb+srv://admin:Password123@dev.06pypjt.mongodb.net/?retryWrites=true&w=majority'
let client;
app.use(bodyParser.json())

async function connectToDatabase() {
    mongoose.connect(uri, {
        serverApi: {
            version: ServerApiVersion.v1,
            strict: true,
            deprecationErrors: true
        },
        ssl: true
    })
    client = mongoose.connection

    client.on('error', console.error.bind(console, 'MongoDB connection error:'))
    client.once('open', () => {
        console.log('Connected to MongoDB')
    })
}

app.use(express.json())
app.use('/auth', authRoutes)
app.use('/class', classRoutes)
app.use('/schedule', scheduleRoutes)
app.use('/user', userRoutes)
app.use('/event', eventRoutes)
app.use('/alert', alertRoutes)
app.use('/assignment', assignmentRoutes)
app.use('/notification', notificationRoutes)

connectToDatabase().then(() => {
    app.listen(3000, () => {
        console.log('Server running on port 3000')
    })
})
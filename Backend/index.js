const express = require('express')
const app = express()
const authRoutes = require('./routes/authRoutes')
const classRoutes = require('./routes/classRoutes')
const { MongoClient, ServerApiVersion } = require('mongodb')
const mongoose = require('mongoose')

const uri = 'mongodb+srv://admin:Password123@dev.06pypjt.mongodb.net/?retryWrites=true&w=majority'
let client;

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
app.use('/auth', authRoutes);
app.use('/class', classRoutes);

connectToDatabase().then(() => {
    app.listen(3000, () => {
        console.log('Server running on port 3000')
    })
})
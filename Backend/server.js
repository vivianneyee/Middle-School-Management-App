const express = require('express')
const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb')
const bcrypt = require('bcrypt')

const app = express()
const router = express.Router()
// const port = 3000

const saltRounds = 10

const mongoURI = "mongodb+srv://vyee072@uottawa.ca:Nicoley.09@dev.06pypjt.mongodb.net/?retryWrites=true&w=majority"

// const client = new MongoClient(mongoURI, {
//     useNewUrlParser:true,
//     useUnifiedTopology: true
// })

async function connectToDatabase() {
    const client = new MongoClient(mongoURI, {
        useNewUrlParser:true,
        useUnifiedTopology: true
    })

    await client.connect()
    console.log("connected to the database")
    return client.db();
}

// Users APIs

// register new user
app.post('/api/register', async (req, res) => {
    try {
        await client.connect();
        const database = client.db('Dev')
        const users = database.collection('users')

        const userId = new ObjectId()
        const { email, password, confirmPassword, role} = req.body

        // check if passwords match
        if (password !== confirmPassword) {
            return res.status(400).json({error: "Passwords do not match"})
        }

        // check if user already exists
        const existingUser = await users.findOne({email})
        if (existingUser) {
            return res.status(400).json({error: 'User already exists'})
        }

        // hash password
        const hashedPassword = await bcrypt.hash(password, saltRounds)

        // add new user to users collection
        const newUser = {
            _id: userId,
            email,
            password: hashedPassword,
            role
        };

        await users.insertOne(newUser) 
        res.json({message: 'User registered successfully'})
    } catch (error) {
        console.error(error)
        res.status(500).json({error: 'Internal Server Error'})
    } finally {
        await client.close()
    }
})

// log in user
app.post('api/login', async (req, res) => {
    try {
        await client.connect()
        const database = client.db('Dev');
        const usersCollection = database.collection('users')

        const {email, password} = req.body

        // find the user with the provided email
        const user = await usersCollection.findOne({email});

        if (!user) {
            return res.status(401).json({error: 'Invalid credentials'})
        }

        const passwordMatch = await bcrypt.compare(password, user.password);

        
    } catch (error) {
        console.error(error);
        res.status(500).json({error: "Internal Server Error"})
    } finally {
        await client.close()
    }
})


// app.listen(port, () => {
//     console.log(`Server is running on port ${port}`)
// })
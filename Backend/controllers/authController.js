const { MongoClient, ServerApiVersion, ObjectId } = require('mongodb')
const bcrypt = require('bcrypt')
const User = require('../models/User')

const saltRounds = 10

exports.register = async (req, res) => {
    const { email, password, confirmPassword, role } = req.body
    
    // check if passwords match, return 400 error if not
    if (password !== confirmPassword) {
        return res.status(400).json({ message: 'Passwords do not match' })
    }

    try {
        // check if user exists already
        const existingUser = await User.findOne({ email: email }).exec()
        if (existingUser) {
            return res.status(400).json({ message: 'Email address is already in use' })
        }

        // hash password
        const hashedPassword = await bcrypt.hash(password, 10)

        // create new user
        const user = new User({
            email: email,
            hashedPassword: hashedPassword,
            role: role
        })

        await user.save()

        return res.status(200).json({ message: 'User registered successfully', _id: user._id })
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ message: 'Internal Server Error' })
    }
}

exports.login = async (req, res) => {
    try {
        const { email, password } = req.body

        // find user with provided email
        const user = await User.findOne({email: email})

        if (!user) {
             return res.status(401).json({ error: 'Invalid credentials' })
        }

        const passwordMatch = await bcrypt.compareSync(password, user.hashedPassword)

        // successful login if passwords match
        if (passwordMatch) {
            console.log('Login successful')
            return res.status(200).json({message: 'Login successful', user: {
                _id: user._id, 
                email: user.email, 
                role: user.role, 
                schedule: user.schedule, 
                classes: user.classes, 
                notifications: user.notifications
            }})
        } else {
            // 401 error if passwords do not match
            res.status(401).json({error: 'Invalid credentials'})
        }
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    } 
}
const Class = require('../models/Class')

// create class
exports.createClass = async (req, res) => {

    const { className, color } = req.body

    const generateUniqueCode = () => {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        let code = '';
        for (let i = 0; i < 6; i++) {
            const randomIndex = Math.floor(Math.random() * characters.length);
            code += characters[randomIndex];
        }
        return code;
    };

    // check if generated code is unique, otherwise, regenerate code
    let code;
    do {
        code = generateUniqueCode();
    } while (await Class.findOne({ code: code }));

    try {
        // create new class
        const newClass = new Class({
            className: className,
            color: color,
            code: code
        })

        await newClass.save()

        return res.status(201).json({ message: 'Class created successfully' })
    } catch (error) {
        // catch server error
        console.error(error)
        return res.status(500).json({ message: 'Internal Server Error' })
    }
}

// get class by id
exports.getClassById = async (req, res) => {
    const classId = req.params.id

    try {
        const retrievedClass = await Class.findById(classId)

        if (!retrievedClass) {
            return res.status(404),json({ error: 'Class not found' })
        } else {
            return res.status(200).json({ message: 'Class retrieved successfully', retrievedClass})
        }
    } catch (error) {
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }

}

// get class by class code
exports.getClassByCode = async (req, res) => {

    const { code } = req.body

    try {
        // try to find class with code from request body
        const retrievedClass = await Class.findOne({ code: code }).exec()
            
        // check if class with that code exists
        if (retrievedClass) {
            // return class if it exists
            return res.status(200).json({message: 'Class retrieved successfully', class: {
                _id: retrievedClass._id,
                className: retrievedClass.className, 
                color: retrievedClass.color, 
                code: retrievedClass.code, 
                events: retrievedClass.events, 
                assignments: retrievedClass.assignments,
                alerts: retrievedClass.alerts,
                studentInputs: retrievedClass.studentInputs
            }})
        } else {
            // 404 if class does not exist
            return res.status(404).json({ error: 'Class not found' })
        }
    } catch (error) {
        console.error(error)
        return res.status(500).json({ error: 'Internal Server Error' })
    }

    
}

// update class
exports.updateClass = async (req, res) => {
    const classId = req.params.id
    const { className, color } = req.body

    try {
        // find the class by id and update className and color
        const updatedClass = await Class.findByIdAndUpdate(classId, { className, color }, { new: true })

        if (!updatedClass) {
            // 404 if class with given id does not exist
            return res.status(404).json({ error: 'Class not found' })
        }

        res.status(200).json(updatedClass)
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}

// delete class
exports.deleteClass = async (req, res) => {
    const classId = req.params.id

    try {
        // find the class by id and delete
        const deletedClass = await Class.findByIdAndDelete(classId)

        if (!deletedClass) {
            // 404 if class with given id does not exist
            return res.status(404).json({ error: 'Class not found' })
        }

        res.status(200).json({ message: 'Class deleted successfully' })
    } catch (error) {
        console.error(error)
        res.status(500).json({ error: 'Internal Server Error' })
    }
}
const express = require('express');
const router = express.Router();
const classController = require('../controllers/classController');

router.post('/classes', classController.createClass);
router.get('/classes/id/:id', classController.getClassById);
router.get('/classes/code/:code', classController.getClassByCode);
router.get('/classes/name/:className', classController.getClassByName);
router.put('/classes/:id', classController.updateClass);
router.put('/classes/events/:id', classController.addEvent);
router.put('/classes/assignments/:id', classController.addAssignment);
router.put('/classes/alerts/:id', classController.addAlert);
router.put('/classes/user/:id', classController.addUser);
router.delete('/classes/:id', classController.deleteClass);

module.exports = router
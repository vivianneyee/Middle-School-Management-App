const express = require('express');
const router = express.Router();
const classController = require('../controllers/classController');

router.post('/classes', classController.createClass);
router.get('/classes/:id', classController.getClassById);
router.get('/classes/:code', classController.getClassByCode);
router.put('/classes/:id', classController.updateClass);
router.delete('/classes/:id', classController.deleteClass);

module.exports = router
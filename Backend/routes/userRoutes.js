const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

router.get('/users/:id', userController.getUserById);
router.delete('/users/:id', userController.deleteUser);
router.put('/users/:id', userController.setSchedule);
router.put('/users/:id', userController.addClass);
router.put('/users/:id', userController.addNotification);

module.exports = router
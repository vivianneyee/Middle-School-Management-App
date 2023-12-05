const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

router.get('/users/:id', userController.getUserById);
router.delete('/users/:id', userController.deleteUser);
router.put('/users/:id/schedule', userController.setSchedule);
router.put('/users/:id/classes', userController.addClass);
router.put('/users/:id/notifications', userController.addNotification);

module.exports = router
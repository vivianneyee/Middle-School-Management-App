const express = require('express');
const router = express.Router();
const notificationController = require('../controllers/notificationController');

router.post('/events', notificationController.createNotification);
router.get('/events/:id', notificationController.getNotificationById);
router.delete('/events/:id', notificationController.deleteNotification);

module.exports = router
const express = require('express');
const router = express.Router();
const eventController = require('../controllers/eventController');

router.post('/events', eventController.createEvent);
router.get('/events/:id', eventController.getEventById);
router.put('/events/:id', eventController.updateEvent);
router.delete('/events/:id', eventController.deleteEvent);

module.exports = router
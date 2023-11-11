const express = require('express');
const router = express.Router();
const scheduleController = require('../controllers/scheduleController');

router.post('/schedules', scheduleController.createSchedule);
router.get('/schedules/:id', scheduleController.getScheduleById);
router.put('/schedules/:id', scheduleController.updateSchedule);
router.delete('/schedules/:id', scheduleController.deleteSchedule);

module.exports = router
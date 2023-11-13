const express = require('express');
const router = express.Router();
const assignmentController = require('../controllers/assignmentController');

router.post('/assignments', assignmentController.createAssignment);
router.get('/assignments/:id', assignmentController.getAssignmentById);
router.put('/assignments/:id', assignmentController.updateAssignment);
router.delete('/assignments/:id', assignmentController.deleteAssignment);

module.exports = router
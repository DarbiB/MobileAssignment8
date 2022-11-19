const mongoose = require('mongoose');   
const Schema = mongoose.Schema;

const Student = new Schema({
    fname:
    {
        type: String,
        required: true
    },
    lname:
    {
        type: String,
        required: true
    },
    studentID:
    {
        type: String,
        required: true
    },
    courseID:
    {
        type: String,
        required: false
    },
    courseName:
    {
        type: String,
        required: false
    },
    dateEntered:
    {
        type: Date,
        required: true,
        default: () => new Date(),
    }
});

mongoose.model('Student', Student);
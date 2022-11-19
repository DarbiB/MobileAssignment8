const express = require('express');  
const app = express();   
const noedmon = require('nodemon');   
app.use(express.json());  

//MongoDB Package
const mongoose = require('mongoose');

const PORT = 1200;

const dbUrl = "mongodb+srv://admin:Password1@cluster0.rjpy4le.mongodb.net/?retryWrites=true&w=majority"

//Connect to MongoDB
mongoose.connect(dbUrl,
{
    useNewUrlParser: true,
    useUnifiedTopology: true
    
});

//MongoDB Connection
const db = mongoose.connection

//Handle DB Error, display connection
db.on('error', () => {
    console.error.bind(console, 'connection error: ');
});

db.once('open', () => {
    console.log('MongoDB Connected');
});

//Schema/Model Declaration
require('./Models/Courses');
require('./Models/Students');

const Course = mongoose.model('Course');
const Student = mongoose.model('Student');

app.get('/', (req, res) =>{
    return res.status(200).json("(message: OK)");
});

app.post('/addCourse', async (req,res) =>{
    try{
        let course = {
            courseInstructor: req.body.courseInstructor,
            courseCredits: req.body.courseCredits,
            courseID: req.body.courseID,
            courseName: req.body.courseName
        }
        await Course(course).save().then(c =>{
            return res.status(201).json("Course Added!");
        });
    }
    catch{
        return res.status(500).json("(message: failed to add course - bad data)");
    }
});

app.get('/getAllCourses',  async (req,res) =>{
    try{
        let course = await Course.find({}).lean();
        return res.status(200).json({"courses" : course});
    }
    catch{
        return res.status(500).json("(message: failed to access course data)");
    }
});


app.post('/addStudent', async (req,res) =>{
    try{
        let student = {
            fname: req.body.fname,
            lname: req.body.lname,
            studentID: req.body.studentID,
            courseID: req.body.courseID,
            courseName: req.body.courseName
        }
        await Student(student).save().then(c =>{
            return res.status(201).json("Student Added!");
        });
    }
    catch{
        return res.status(500).json("(message: failed to add student - bad data)");
    }
});

app.get('/getAllStudents',  async (req,res) =>{
    try{
        let student = await Student.find({}).lean();
        return res.status(200).json({"students" : student});
    }
    catch{
        return res.status(500).json("(message: failed to access student data)");
    }
});


app.get('/findStudent',  async (req,res) =>{
    try{
        let student = await Student.find(req.body).lean();
        return res.status(200).json(student);
    }
    catch{
        return res.status(500).json("(message: failed to access student data)");
    }
});

app.get('/findCourse',  async (req,res) =>{
    try{
        let course = await Course.find(req.body).lean();
        return res.status(200).json(course);
    }
    catch{
        return res.status(500).json("(message: failed to access course data)");
    }
});

app.post('/editStudentById', async (req,res)=>{
    try{
        let student = await Student.updateOne({_id: req.body.id}
            ,{
                fname: req.body.fname
            },{upsert: true});
            
        if(student)
        {
            res.status(200).json("{message: First Name Edited}");       
        }
        else{
            res.status(200).json("{message: No Name Changed}");
        }
    }
    catch{
        return res.status(500).json("{message: Failed to edit name}");
    }

});

app.post('/editStudentByFname', async (req,res)=>{
    try{
        let student = await Student.updateOne({fname: req.body.queryFname}
            ,{
                fname: req.body.fname,
                lname: req.body.lname
            },{upsert: true});
            
        if(student)
        {
            res.status(200).json("{message: First & Last Name Modified}");       
        }
        else{
            res.status(200).json("{message: No Name Modified}");
        }
    }
    catch{
        return res.status(500).json("{message: Failed to edit name}");
    }

});

app.post('/editCourseByCourseName', async (req,res)=>{
    try{
        let student = await Course.updateOne({courseName: req.body.courseName}
            ,{
                courseInstructor: req.body.instructorName
            },{upsert: true});
            
        if(student)
        {
            res.status(200).json("{message: Course Modified}");       
        }
        else{
            res.status(200).json("{message: No Course Modified}");
        }
    }
    catch{
        return res.status(500).json("{message: Failed to edit course}");
    }

});


app.post('/deleteCourseById', async(req,res)=>{
    try{
        let course = await Course.findOne({_id: req.body.id});
        if(course){
            await Course.deleteOne({_id: req.body.id});
            return res.status(200).json("{message: Course Deleted}")
        }
        else{
            return res.status(200).json("{message: No course deleted - query null}")
        }
    }
    catch{
        return res.status(500).json("{message: Failed to delete course}");
    }

});

app.post('/removeStudentFromClasses', async(req,res)=>{
    try{
        let student = await Student.findOne({studentID: req.body.studentId});
        if(student){
            student.courseID = undefined;
            student.courseName = undefined;
            student.save();
            //await Student.removeOne({courseID, courseName});
            return res.status(200).json("{message: Student removed from classes}")
        }
        else{
            return res.status(200).json("{message: Student not removed - query null}")
        }
    }
    catch{
        return res.status(500).json("{message: Failed to remove student}");
    }

});

app.post('/deleteStudentById', async(req,res)=>{
    try{
        let course = await Student.findOne({_id: req.body.id});
        if(course){
            await Student.deleteOne({_id: req.body.id});
            return res.status(200).json("{message: Student Deleted}")
        }
        else{
            return res.status(200).json("{message: No student deleted - query null}")
        }
    }
    catch{
        return res.status(500).json("{message: Failed to delete student}");
    }

});



app.listen(PORT, () => {
    console.log(`Server Started on port ${PORT}`);
});
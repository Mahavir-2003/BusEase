import mongoose from "mongoose";

const userSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true,
    },
    middleName: {
        type: String,
        required: true,
    },
    lastName: {
        type: String,
        required: true
    },
    dob: {
        type: Date,
        required: true
    },
    gender: {
        type: String,
        enum: ['male', 'female', 'other'],
        required: true
    },
    phoneNumber: {
        type: String,
        required: true,
        unique: true,
        match: [/^\d{10}$/, 'Please fill a valid phone number'],
    },
    email: {
        type: String,
        required: true,
        unique: true,
        match: [/\S+@\S+\.\S+/, 'Please fill a valid email address'],
    },
    aadharCardNumber: {
        type: String,
        required: true,
        unique: true,
        match: [/^\d{12}$/, 'Please fill a valid Aadhar card number'],
    },
    password: {
        type: String,
        required: true,
        Selection: false
    },
    role: {
        type: String,
        enum: ['user', 'gsrtcAdmin', 'collageAdmin','student','traveller' , 'ticketChecker'],
        default: 'user',
        required: true
    }
},{ timestamps: true });

const User = mongoose.model('User', userSchema);

export default User;
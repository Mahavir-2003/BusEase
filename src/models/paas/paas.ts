import mongoose from "mongoose";

// paas contains user id, organization name, from(location) , to , status, created at , expiry date, paas type, depot ;
const paasSchema = new mongoose.Schema({
    user : {
        type : mongoose.Schema.Types.ObjectId,
        ref : 'User',
        required : true
    },
    organization : {
        type : String,
        required : true
    },
    from : {
        type : String,
        required : true
    },
    to : {
        type : String,
        required : true
    },
    status : {
        type : Boolean,
        required : true
    },
    createdAt : {
        type : Date,
        required : true
    },
    expiryDate : {
        type : Date,
        required : true
    },
    paasType: {
        type: String,
        enum: ['NORMAL', 'EXPRESS'],
        required: true
    },
    depot : {
        type : String,
        required : true
    }
});

const Paas = mongoose.model('Paas', paasSchema);

export default Paas;
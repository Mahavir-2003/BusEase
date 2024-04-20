import mongoose from "mongoose";

// ticket should automatically destroyed in 24 hours
const ticketSchema = new mongoose.Schema({
  userID : {
    type : mongoose.Schema.Types.ObjectId,
    ref : 'User',
    required : true
  },
  paasId : {
    type : mongoose.Schema.Types.ObjectId,
    ref : 'Paas',
    required : true
  },
  passengerName : {
    type : String,
    required : true
  },
  Date:{
    type: Date,
    default: Date.now,
  },
  Depot :{
    type : String,
    required : true
  },
  type :{
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
    ticketQuantity : {
        type : Number,
        required : true
    },
    ticketPrice : {
        type : Number,
        required : true
    },
    createdAt: {
        type: Date,
        default: Date.now,
    }
},{timestamps: true});

ticketSchema.index({createdAt: 1},{expireAfterSeconds: 86400});

const Ticket = mongoose.model('Tickets', ticketSchema);

export default Ticket;
//Import from Package
const express = require('express');
const mongoose = require('mongoose'); //importing mongoose

//Import from OTHER FILES
const authRouter = require("./routes/auth");

//INITIALIZATION
const PORT = 3000;
const app = express()
const DB = "mongodb+srv://shubham:shubham123@cluster0.vb3wmmd.mongodb.net/?retryWrites=true&w=majority";

//adding middleware
//CLINT SIDE - > MIIDLE WARE- >  SERVER SIDE - > CLIENT SIDE
//this is called middle ware
app.use(express.json());
app.use(authRouter);


//connecttion to database
mongoose
    .connect(DB)
    .then(() => {
    console.log('connected to mongoDB');
})
.catch((e) => {
    console.log( e);
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port  ${PORT}`);
});



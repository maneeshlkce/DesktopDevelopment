const mysrvdemo = (srvice)=>{
     srvice.on("somefn",(req,res)=>{
       return "Hello  " + req.data.msg;
     });
}

module.exports = mysrvdemo;
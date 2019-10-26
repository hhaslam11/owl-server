const express = require('express');
const bodyParser = require('body-parser');

require('dotenv').config();
const PORT = process.env.SERVER_PORT;

const app = express();

//middleware
app.use(bodyParser.urlencoded({extended: true}));

//routers

//starts listening
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
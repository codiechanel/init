'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  let str = process.env.NODE_ENV
  res.send(str + 'Hello coolness fast great world\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
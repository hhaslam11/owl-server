const fs = require('fs');
const { arrToRbCreateSeed } = require('./helpers.js');

fs.readFile('./userdata.csv', "utf8", (err, data) => {
  if (err) throw err;

  let rows = data.split('\n');
  let result = rows.map(el => {
    splitRow = el.split(',')
    return `{ email: '${splitRow[0]}', username: '${splitRow[1]}', password: '${splitRow[2]}' }`
  })

  resultString = arrToRbCreateSeed('User', result);
  
  fs.writeFile('./user_seeds.rb', resultString, (err) => {
    if (err) throw err;
    console.log('The file has been saved!');
  });
});
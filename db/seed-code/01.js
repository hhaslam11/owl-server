const fs = require('fs');
fs.readFile('./userdata.csv', "utf8", (err, data) => {
  if (err) throw err;

  let rows = data.split('\n');
  let result = rows.map(el => {
    splitRow = el.split(',')
    return `{ email: '${splitRow[0]}', username: '${splitRow[1]}', password: '${splitRow[2]}'}`
  })

  let resultString = 'User.create(['
  for (let i = 0; i < result.length; i++) {
    resultString += result[i]
    if (i < (result.length - 1)) {
      resultString += ', '
    } else {
      resultString += '])'
    }
  }

  console.log(resultString, typeof resultString);
  
  fs.writeFile('./user_seeds.rb', resultString, (err) => {
    if (err) throw err;
    console.log('The file has been saved!');
  });
});
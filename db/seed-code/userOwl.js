const fs = require('fs');
const { arrToRbCreateSeed } = require('./helpers.js');

result = []
for (let i = 1; i < 498; i++) {
  result.push(`{ user_id: ${i}, owl_id: 1 }`)
}

resultString = arrToRbCreateSeed('UserOwl', result);

fs.writeFile('./user_owl_seeds.rb', resultString, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
});
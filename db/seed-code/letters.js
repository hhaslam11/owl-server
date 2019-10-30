const fs = require('fs');
const { arrToRbCreateSeed } = require('./helpers.js');
const { string1, string2, string3, string4, string5 } = require('./randomText.js');

result = []

//sender id 101-200: one letter, on its way
for (let i = 101; i < 201; i++) {
  result.push(`{ sender_id: ${i}, country_id: ${Math.round(Math.random()*750)}, user_owl_id: ${i}, content: "${string1}", sent_date: ${Date.now()} }`)
}

//sender id 201-300: two letters, first received by id 0-100, last on its way
for (let i = 201; i < 301; i++) {
  result.push(`{ sender_id: ${i}, country_id: ${Math.round(Math.random()*750)}, user_owl_id: ${i}, receiver_id: ${Math.round(Math.random()*100)}, content: "${string1}", sent_date: ${Date.now() - 9853500}, delivery_date: ${Date.now() - 853500}, pick_up_date: ${Date.now()}}`)
  result.push(`{ sender_id: ${i}, country_id: ${Math.round(Math.random()*750)}, user_owl_id: ${i}, content: "${string3}", sent_date: ${Date.now()} }`)
}

//sender id 301-500: three letters, first received by id 0-300, second in post office, last on its way
for (let i = 301; i < 501; i++) {
  result.push(`{ sender_id: ${i}, country_id: ${Math.round(Math.random()*750)}, user_owl_id: ${i}, receiver_id: ${Math.round(Math.random()*300)}, content: "${string1 + string2}", sent_date: ${Date.now() - 9853500}, delivery_date: ${Date.now() - 853500}, pick_up_date: ${Date.now()}}`)
  result.push(`{ sender_id: ${i}, country_id: ${Math.round(Math.random()*750)}, user_owl_id: ${i}, content: "${string2}", sent_date: ${Date.now() - 853500}, delivery_date: ${Date.now()}}`)
  result.push(`{ sender_id: ${i}, country_id: ${Math.round(Math.random()*750)}, user_owl_id: ${i}, content: "${string5}", sent_date: ${Date.now()} }`)
}

resultString = arrToRbCreateSeed('Letter', result);

fs.writeFile('./letter_seeds.rb', resultString, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
});
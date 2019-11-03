const fs = require('fs');
const { arrToRbCreateSeed, roundRandNum } = require('./helpers.js');
const { string1, string2, string3, string4, string5 } = require('./randomText.js');

result = []

//sender id 101-200: one letter, on its way
for (let i = 101; i < 201; i++) {
  result.push(`{ sender_id: ${i}, to_country_id: ${roundRandNum(250)}, from_country_id: ${roundRandNum(250)}, user_owl_id: ${i}, content: "${string1}", sent_date: Time.current }`)
}

//sender id 201-300: two letters, first received by id 0-100, last on its way
for (let i = 201; i < 301; i++) {
  result.push(`{ sender_id: ${i}, to_country_id: ${roundRandNum(250)}, from_country_id: ${roundRandNum(250)}, user_owl_id: ${i}, receiver_id: ${roundRandNum(100)}, content: "${string1}", sent_date: Time.current - 259200, delivery_date: Time.current - 172800, pick_up_date: Time.current - 86400}`)
  result.push(`{ sender_id: ${i}, to_country_id: ${roundRandNum(250)}, from_country_id: ${roundRandNum(250)}, user_owl_id: ${i}, content: "${string3}", sent_date: Time.current }`)
}

//sender id 301-479: three letters, first received by id 0-300, second in post office, last on its way
for (let i = 301; i < 480; i++) {
  result.push(`{ sender_id: ${i}, to_country_id: ${roundRandNum(250)}, from_country_id: ${roundRandNum(250)}, user_owl_id: ${i}, receiver_id: ${roundRandNum(300)}, content: "${string4 + string2}", sent_date: Time.current - 259200, delivery_date: Time.current - 172800, pick_up_date: Time.current - 86400}`)
  result.push(`{ sender_id: ${i}, to_country_id: ${roundRandNum(250)}, from_country_id: ${roundRandNum(250)}, user_owl_id: ${i}, content: "${string2}", sent_date: Time.current - 172800, delivery_date: Time.current - 86400}`)
  result.push(`{ sender_id: ${i}, to_country_id: ${roundRandNum(250)}, from_country_id: ${roundRandNum(250)}, user_owl_id: ${i}, content: "${string5}", sent_date: Time.current }`)
}

resultString = arrToRbCreateSeed('Letter', result);

fs.writeFile('./letter_seeds.rb', resultString, (err) => {
  if (err) throw err;
  console.log('The file has been saved!');
});
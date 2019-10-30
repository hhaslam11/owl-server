const https = require('https');
const fs = require('fs');
const { arrToRbCreateSeed } = require('./helpers.js');

https.get('https://restcountries.eu/rest/v2/all?fields=languages', (resp) => {
  let data = '';
  // A chunk of data has been recieved.
  resp.on('data', (chunk) => {
    data += chunk;
  });

  // The whole response has been received. Work with data
  resp.on('end', () => {
    let parsedData = (JSON.parse(data));

    let languages = {}
    parsedData.forEach(el => {
      el.languages.forEach(elm => {
        languages[elm.name] = 1
      })
    });
    languages = Object.keys(languages)

    let langSeedArr = languages.map(el => {
      return `{ name: '${el}'}`
    })

    resultString = arrToRbCreateSeed('Language', langSeedArr);

    fs.writeFile('./language_seeds.rb', resultString, (err) => {
      if (err) throw err;
      console.log('The file has been saved!');
    });
  });

}).on("error", (err) => {
  console.log("Error: " + err.message);
});
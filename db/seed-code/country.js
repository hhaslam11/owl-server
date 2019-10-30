const https = require('https');
const fs = require('fs');
const { arrToRbCreateSeed, utcToAvgInt } = require('./helpers.js');

https.get('https://restcountries.eu/rest/v2/all?fields=name;alpha2Code;languages;timezones;flag', (resp) => {
  let data = '';
  // A chunk of data has been recieved.
  resp.on('data', (chunk) => {
    data += chunk;
  });

  // The whole response has been received. Work with data
  resp.on('end', () => {
    let parsedData = (JSON.parse(data));

    //mimicking database languages table as an object with language names as keys and language ids as values
    const languagesIds = (parsedData) => {
      let languages = {}
      let counter = 1;
      parsedData.forEach(el => {
        el.languages.forEach(elm => {
          if (!languages[elm.name]) {
            languages[elm.name] = counter
            counter ++;
          }
        })
      });
      return languages
    }

    let countrySeedArr = parsedData.map(el => {
      //setting ids of languages inside an array
      resultLanguages = [];
      el.languages.forEach(elm => {
        resultLanguages.push(languagesIds(parsedData)[elm.name])
      })
      console.log(utcToAvgInt(el.timezones));
      return `{ name: "${el.name}", abbreviation: '${el.alpha2Code}', timezone: ${utcToAvgInt(el.timezones)}, flag_image: '${el.flag}', language_ids: [${resultLanguages}]}`
    })

    resultString = arrToRbCreateSeed('Country', countrySeedArr);

    fs.writeFile('./country_seeds.rb', resultString, (err) => {
      if (err) throw err;
      console.log('The file has been saved!');
    });
  });

}).on("error", (err) => {
  console.log("Error: " + err.message);
});

// Example create query: 
// Country.create([{ name: 'Guinea', abbreviation: 'GN', timezone: 0, flag_image: 'https://restcountries.eu/data/gin.svg' }])

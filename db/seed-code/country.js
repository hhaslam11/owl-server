const { arrToRbCreateSeed, utcToAvgInt, getDataPromise, writeDataPromise, getAPIDataPromise } = require('./helpers.js');

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

//setting ids of languages inside an array
const lang = (inputLang, parsedData) => {
  resultLanguages = [];
  inputLang.forEach(elm => {
    resultLanguages.push(languagesIds(parsedData)[elm.name])
  })
  return resultLanguages
}

//getting an object of latitude and longditude for each country code
const latLonObj = (csvData) => {
  let rows = csvData.split('\n');
  const result = {}
  for (const row of rows) {
    splitRow = row.split(',')
    result[splitRow[0]] = {lat: Number(splitRow[1]), lon: Number(splitRow[2])}
  }
  return result;
}

getAPIDataPromise('https://restcountries.eu/rest/v2/all?fields=name;alpha2Code;languages;timezones;flag')
.then(data => {
  let parsedData = (JSON.parse(data));
  
  getDataPromise('./countryLatLan.csv')
  .then(data => latLonObj(data))
  .then(obj => {

  return countrySeedArr = parsedData.map(el => {
      return `{ name: "${el.name}", abbreviation: '${el.alpha2Code}', timezone: ${utcToAvgInt(el.timezones)}, lat: ${obj[el.alpha2Code]? obj[el.alpha2Code].lat : 'nil'}, lon: ${obj[el.alpha2Code]? obj[el.alpha2Code].lon : 'nil'}, flag_image: '${el.flag}', language_ids: [${lang(el.languages, parsedData)}]}`
    })
  })
  .then(arr => {
    return resultString = arrToRbCreateSeed('Country', arr);
  })
  .then(result => {
    return writeDataPromise('./country_seeds.rb', result)
  })
  .then(data => console.log(data))
  .catch(err => console.log(err))
})
.catch(err => console.log(err));

// Example create query: 
// Country.create([{ name: 'Guinea', abbreviation: 'GN', timezone: 0, flag_image: 'https://restcountries.eu/data/gin.svg' }])




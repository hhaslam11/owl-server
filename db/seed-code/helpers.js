const fs = require('fs');
const https = require('https');
/**
 * 
 * @param {String} seedName e.g. User/Country/Langage,..
 * @param {Array} array 
 */
const arrToRbCreateSeed = (seedName, array) => {
  let seedString = `${seedName}.create([`
  for (let i = 0; i < array.length; i++) {
    seedString += array[i]
    if (i < (array.length - 1)) {
      seedString += ', '
    } else {
      seedString += '])'
    }
  }
  return seedString
}

// Possible timezone formats:
// 'UTC'
// 'UTC-05:00'
// 'UTC+05:00'
// ["UTC-03:00", "UTC+03:00", "UTC+05:00", "UTC+06:00", "UTC+07:00", "UTC+08:00", "UTC+10:00", "UTC+12:00"]

const utcToAvgInt = (utcArr) => {
  resultArr = []
  result = 0
  intArr = utcArr.map(el => {
    number = Number(el.replace(/UTC|\:(.*)/g, ''));
    resultArr.push(number);
    result += number;
  })
 return result / resultArr.length
}

const roundRandNum = (max) => {
  return Math.round(Math.random() * (max - 1) + 1)
}

const getDataPromise = (fileName) => {
  return new Promise(function(resolve, reject){
    fs.readFile(fileName, "utf8", (err, data) => {
        err ? reject(err) : resolve(data);
    });
  });
}

const writeDataPromise = (fileName, data) => {
  return new Promise((resolve, reject) => {
    fs.writeFile(fileName, data, (err) => {
        err ? reject(err) : resolve('The file has been saved!');
    });
  });
}

const getAPIDataPromise = (path) => {
  return new Promise((resolve, reject) => {
    https.get(path, (resp) => {
      let data = '';

      resp.on('data', (chunk) => {
        data += chunk;
      });
    
      resp.on('end', () => {
        resolve(data)
      });
    
    }).on("error", (err) => {
      reject(err.message)
    });
  });
}

module.exports = { arrToRbCreateSeed, utcToAvgInt, roundRandNum, getDataPromise, writeDataPromise, getAPIDataPromise };
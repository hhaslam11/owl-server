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
  return Math.round(Math.random()*max)
}

module.exports = { arrToRbCreateSeed, utcToAvgInt, roundRandNum };
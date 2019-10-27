'use strict';
module.exports = {
  up: (sequelize) => {
    return sequelize.createSchema('schema').then(() => {
      // new schema is created
   });
  },
  down: (sequelize) => {
    return sequelize.dropSchema('schema');
  }
};
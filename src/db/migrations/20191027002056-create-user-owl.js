'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('UserOwls', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      }
    }, {schema: 'schema'});
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('UserOwls');
  }
};
'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('Countries', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      name: {
        allowNull: false,
        type: Sequelize.STRING
      },
      abbreviation: {
        allowNull: false,
        type: Sequelize.STRING
      },
      timezone: {
        allowNull: false,
        type: Sequelize.INTEGER
      },
      flagImage: {
        allowNull: false,
        type: Sequelize.STRING
      }
    }, {schema: 'schema'});
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('Countries');
  }
};
'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('Seals', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      title: {
        allowNull: false,
        type: Sequelize.STRING
      },
      image: {
        allowNull: false,
        type: Sequelize.STRING
      }
    }, {schema: 'schema'});
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('Seals');
  }
};
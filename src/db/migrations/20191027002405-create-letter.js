'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('Letters', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      content: {
        allowNull: false,
        type: Sequelize.TEXT
      },
      sentDate: {
        allowNull: false,
        defaultValue: Sequelize.fn('now'),
        type: Sequelize.DATE
      },
      deliveryDate: {
        type: Sequelize.DATE
      },
      pickUpDate: {
        type: Sequelize.DATE
      }
    }, {schema: 'schema'});
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('Letters');
  }
};
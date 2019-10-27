'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('Owls', {
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
      speed: {
        allowNull: false,
        type: Sequelize.INTEGER
      },
      carryingCapacity: {
        allowNull: false,
        type: Sequelize.INTEGER
      },
      image: {
        allowNull: false,
        type: Sequelize.STRING
      }
    }, {schema: 'schema'});
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('Owls');
  }
};
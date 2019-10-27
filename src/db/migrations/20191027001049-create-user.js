'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('Users', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      email: {
        allowNull: false,
        type: Sequelize.STRING
      },
      username: {
        allowNull: false,
        type: Sequelize.STRING
      },
      password: {
        allowNull: false,
        type: Sequelize.STRING
      },
      avatar: {
        type: Sequelize.STRING
      },
      join_date: {
        allowNull: false,
        defaultValue: Sequelize.fn('now'),
        type: Sequelize.DATE
      },
      last_login: {
        allowNull: false,
        defaultValue: Sequelize.fn('now'),
        type: Sequelize.DATE
      }
    }, {schema: 'schema'});
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('Users');
  }
};
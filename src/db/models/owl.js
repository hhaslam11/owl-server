'use strict';
module.exports = (sequelize, DataTypes) => {
  const Owl = sequelize.define('Owl', {
    name: DataTypes.STRING,
    speed: DataTypes.INTEGER,
    carryingCapacity: DataTypes.INTEGER,
    image: DataTypes.STRING
  }, {});
  Owl.associate = function(models) {
    // associations can be defined here
  };
  return Owl;
};
'use strict';
module.exports = (sequelize, DataTypes) => {
  const Country = sequelize.define('Country', {
    name: DataTypes.STRING,
    abbreviation: DataTypes.STRING,
    timezone: DataTypes.INTEGER,
    flagImage: DataTypes.STRING
  }, {});
  Country.associate = function(models) {
  };
  return Country;
};
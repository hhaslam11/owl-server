'use strict';
module.exports = (sequelize, DataTypes) => {
  const Seal = sequelize.define('Seal', {
    countryId: DataTypes.INTEGER,
    title: DataTypes.STRING,
    image: DataTypes.STRING
  }, {});
  Seal.associate = function(models) {
    Seal.belongsTo(models.Country)
  };
  return Seal;
};
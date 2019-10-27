'use strict';
module.exports = (sequelize, DataTypes) => {
  const UserSeal = sequelize.define('UserSeal', {
    userId: DataTypes.INTEGER,
    sealId: DataTypes.INTEGER,
  }, {});
  UserSeal.associate = function(models) {
    UserSeal.belongsTo(models.User)
    UserSeal.belongsTo(models.Seal)
  };
  return UserSeal;
};
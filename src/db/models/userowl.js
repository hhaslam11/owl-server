'use strict';
module.exports = (sequelize, DataTypes) => {
  const UserOwl = sequelize.define('UserOwl', {
    userId: DataTypes.INTEGER,
    owlId: DataTypes.INTEGER
  }, {});
  UserOwl.associate = function(models) {
    UserOwl.belongsTo(models.User)
    UserOwl.belongsTo(models.Owl)
  };
  return UserOwl;
};
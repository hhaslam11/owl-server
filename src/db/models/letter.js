'use strict';
module.exports = (sequelize, DataTypes) => {
  const Letter = sequelize.define('Letter', {
    senderId: DataTypes.INTEGER,
    countryId: DataTypes.INTEGER,
    userOwlId: DataTypes.INTEGER,
    receiverId: DataTypes.INTEGER,
    content: DataTypes.TEXT,
    sentDate: DataTypes.DATE,
    deliveryDate: DataTypes.DATE,
    pickUpDate: DataTypes.DATE
  }, {});
  Letter.associate = function(models) {
    // associations can be defined here
    Letter.belongsTo(models.User, {as: 'sender'})
    Letter.belongsTo(models.Country)
    Letter.belongsTo(models.UserOwl)
    Letter.belongsTo(models.User, {as: 'receiver'})
  };
  return Letter;
};
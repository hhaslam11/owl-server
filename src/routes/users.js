const router = require("express").Router();

module.exports = db => {
  router.post("/users", (request, response) => {
    db.query(``
    ).then(({ rows: users }) => {
      response.json(days);
    });
  });

  router.get("/users/id", (request, response) => {
    db.query(``
    ).then(({ rows: user }) => {
      response.json(user);
    });
  });

  return router;
};
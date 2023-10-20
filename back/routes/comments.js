var express = require('express');
var router = express.Router();
const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  ssl: {
    rejectUnauthorized: false
  }
});

// Fonction pour initialiser la table
async function initializeCommentsTable() {
  const createTableQuery = `
    CREATE TABLE IF NOT EXISTS comments (
      id SERIAL PRIMARY KEY,
      username VARCHAR(255),
      comment TEXT
    );
  `;

  await pool.query(createTableQuery);
}

router.get('/', async function(req, res, next) {
  try {
    // Assurez-vous que la table comments existe
    await initializeCommentsTable();

    let { rows } = await pool.query('SELECT * FROM comments');

    if (rows.length === 0) {
      // Si la base est vide, insérons quelques données pour le test
      const demoData = [
        { username: 'John', comment: 'Hello World!' },
        { username: 'Jane', comment: 'Bonjour!' }
      ];

      for (let data of demoData) {
        await pool.query('INSERT INTO comments (username, comment) VALUES ($1, $2)', [data.username, data.comment]);
      }

      // Récupérons à nouveau les commentaires
      const result = await pool.query('SELECT * FROM comments');
      rows = result.rows;
    }

    res.json(rows);
  } catch (err) {
    next(err);
  }
});


module.exports = router;

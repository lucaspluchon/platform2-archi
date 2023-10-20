import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [comments, setComments] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Utilisez la variable d'environnement pour l'URL de l'API
        const response = await axios.get(process.env.REACT_APP_API_URL);
        setComments(response.data);
      } catch (error) {
        console.error("Erreur lors de la récupération des commentaires:", error);
      }
    };

    fetchData();
  }, []);

  return (
      <div className="App">
        <header className="App-header">
          <h2>Commentaires</h2>
          <ul>
            {comments.map(comment => (
                <li key={comment.id}>
                  <strong>{comment.username}</strong>: {comment.comment}
                </li>
            ))}
          </ul>
        </header>
      </div>
  );
}

export default App;

const express = require("express");
const app = express();
const PORT = 8000;

app.use(express.json());

app.post('/v1/events', (req, res) => {
    console.log('Received payload:', JSON.stringify(req.body, null, 2));
    res.status(200).json({ status: 'received' });
});

app.listen(PORT, () => {
    console.log(`✅ Backend server running on http://localhost:${PORT}`);
});
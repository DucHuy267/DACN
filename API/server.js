const express = require('express');
const path = require('path');
const productRouters = require('./routers/productRouters');
const categoryRouters = require('./routers/categoryRouters');
const userRouters = require('./routers/userRouters');
const cartRouters = require('./routers/cartRouters');
const orderRouters = require('./routers/orderRoutes');
const mongoose = require('mongoose');
const cors = require('cors');
const passport = require("passport");
const dotenv = require("dotenv");
const session = require("express-session");
const jwt = require("jsonwebtoken");

// Khởi tạo express app
const app = express();

// Đọc cấu hình từ file .env
dotenv.config();

require("./config/passport")

// Kết nối tới MongoDB
const connectDB = async () => {
    try {
        await mongoose.connect('mongodb://localhost:27017/cocoon_original');
        console.log('MongoDB connected successfully');
    } catch (err) {
        console.error('Error connecting to MongoDB', err);
        process.exit(1);
    };
};

connectDB();

// Cấu hình session
app.use(
    session({
        secret: "afhgfhfdhgfh123213",
        resave: false,
        saveUninitialized: false,
        cookie: { secure: process.env.NODE_ENV === "production" },
    })
);

// Các middleware
app.use(cors());
app.use(passport.initialize());
app.use(passport.session());

// Cấu hình port
const port = 4000;

// Middleware để parse JSON
app.use(express.json());

// Serve các file tĩnh của React (nếu có)
app.use(express.static(path.join(__dirname, 'build')));

// Định nghĩa các routes
app.use('/products', productRouters);
app.use('/categories', categoryRouters);
app.use('/users', userRouters);
app.use('/carts', cartRouters);
app.use('/orders', orderRouters);

// Các route cho Facebook và Google authentication
app.get(
    "/auth/facebook",
    passport.authenticate("facebook", {
      scope: ["public_profile", "email"],
    })
);

app.get(
    "/auth/facebook/callback",
    passport.authenticate("facebook", {
      failureRedirect: "http://localhost:3000/login?error=true",
      session: false,
    }),
    (req, res) => {
      const token = jwt.sign({ userId: req.user._id }, process.env.JWT_SECRET || 'default_secret', {
        expiresIn: "1h",
      });
      res.redirect(`http://localhost:3000/login?token=${token}`);
    }
);

app.get(
    "/auth/google",
    passport.authenticate("google", {
      scope: ["profile", "email"],
      prompt: "select_account consent",
    })
);

app.get(
    "/auth/google/callback",
    passport.authenticate("google", {
      failureRedirect: "http://localhost:3000/login?error=true",
      session: false,
    }),
    (req, res) => {
      const token = jwt.sign({ userId: req.user._id }, process.env.JWT_SECRET || 'default_secret', {
        expiresIn: "1h",
      });
      res.redirect(`http://localhost:3000/login?token=${token}`);
    }
);

// Lắng nghe port
app.listen(port, () => {
    console.log(`Server is running at http://localhost:${port}`);
});

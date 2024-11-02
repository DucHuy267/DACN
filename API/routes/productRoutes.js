const express = require('express');
const {
    addProduct,
    updateProduct,
    getProductById,
    getProductsByCategoryId,
    getAllProducts,
    searchProductsByName,
    deleteProduct
} = require('../controllers/productController');

const router = express.Router();

// Route để tìm kiếm sản phẩm theo tên
router.get('/search', searchProductsByName);

// Route để lấy tất cả sản phẩm
router.get('/getAll', getAllProducts);

// Route để lấy thông tin sản phẩm theo productId
router.get('/:productId', getProductById);

// Route để lấy danh sách sản phẩm theo categoryId
router.get('/category/:categoryId', getProductsByCategoryId);

// Route để thêm sản phẩm mới
router.post('/addProduct', addProduct);

router.post('/updateProduct', updateProduct);

// Route để xóa sản phẩm
router.delete('/:productId', deleteProduct);

module.exports = router;
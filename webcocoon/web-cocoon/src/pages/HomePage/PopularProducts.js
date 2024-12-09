import React, { useEffect, useState } from 'react';  
import { Card, Button, message } from 'antd';
import { ShoppingOutlined } from '@ant-design/icons';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { jwtDecode } from 'jwt-decode';
import { getAllProduct } from '../../services/ProductServices';

const PopularProducts = () => {
    const [products, setProducts] = useState([]);
    const [userId, setUserId] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        const storedToken = localStorage.getItem('token');
        if (storedToken) {
            try {
                const decoded = jwtDecode(storedToken);
                setUserId(decoded.userId);
            } catch (error) {
                console.error('Failed to decode token:', error);
            }
        }
        fetchProducts();
    }, []);

    const fetchProducts = async () => {
        try {
            const res = await getAllProduct();
            if (res) {
                setProducts(res);
            }
        } catch (error) {
            message.error('Failed to load products.');
        }
    };

    const goToProductDetail = (productId) => {
        if (productId) {
            navigate(`/product/${productId}`);
        } else {
            message.error('Product ID is missing.');
        }
    };

    const handleAddToCart = async (productId, e) => {
        e.preventDefault();
        e.stopPropagation();
        if (!userId) {
            message.info('Please log in to add products to the cart.');
            return;
        }

        const data = {
            userId,
            productId,
            quantity: 1,
        };

        try {
            const response = await axios.post('http://localhost:4000/carts/add', data, {
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            if (response.status === 200) {
                message.success('Product added to cart successfully');
            }
        } catch (error) {
            console.error('Error adding product to cart:', error.response?.data || error);
            message.error('Error adding product to cart');
        }
    };

    return (
        <div style={{ padding: '20px 0', backgroundColor: '#fefbf4' }}>
            <style>
                {`
                    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap');
                    h2, p {
                        font-family: 'Playfair Display', serif;
                        font-style: italic;
                    }
                `}
            </style>
            <div style={{ display: 'flex', padding: '0 30px', marginBottom: '5px' }}>
                <div style={{ flex: '1', marginRight: '20px', marginTop: '200px' }}>
                    <h2 style={{ fontSize: '30px', fontWeight: 'bold', marginBottom: '5px' }}>
                        Sản phẩm
                    </h2>
                    <h2 style={{ fontSize: '30px', fontWeight: 'bold', margin: '0', marginTop: '10px' }}>
                        Bán chạy
                    </h2>
                    <p style={{ fontSize: '14px', color: '#555', marginTop: '10px' }}>
                        Cocoon tự hào khi các sản phẩm mà chúng tôi tạo ra mang đến những thay đổi tuyệt vời trên làn da, mái tóc của bạn.
                    </p>
                </div>
                <div style={{ flex: '3', overflowX: 'auto' }}>
                    {products.length > 0 ? (
                        <div style={{ display: 'flex' }}>
                            {products.map((product) => (
                                <div key={product._id} style={{ marginRight: '16px', flexShrink: 0 }}>
                                    <Card
                                        hoverable
                                        style={{ width: '220px' }}
                                        cover={
                                            product.imageUrl && (
                                                <img
                                                    src={product.imageUrl}
                                                    alt={product.name}
                                                    style={{
                                                        height: '205px',
                                                        objectFit: 'cover',
                                                        borderRadius: '8px 8px 0 0',
                                                    }}
                                                />
                                            )
                                        }
                                        onClick={() => goToProductDetail(product._id)}
                                    >
                                        <Card.Meta
                                            title={<div style={{ fontSize: '16px', fontWeight: 'bold' }}>{product.name}</div>}
                                            description={
                                                <div style={{ fontSize: '14px', color: '#888' }}>
                                                    {`${product.price.toLocaleString('vi-VN')} đ`}
                                                </div>
                                            }
                                        />
                                        <Button
                                            icon={<ShoppingOutlined />}
                                            onClick={(e) => handleAddToCart(product._id, e)}
                                            style={{
                                                marginTop: '10px',
                                                width: '100%',
                                                backgroundColor: '#000',
                                                color: '#fff',
                                                border: 'none',
                                            }}
                                        >
                                            Thêm vào giỏ hàng
                                        </Button>
                                    </Card>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <p style={{ textAlign: 'center', width: '100%' }}>Không có sản phẩm phổ biến.</p>
                    )}
                </div>
            </div>
        </div>
    );
};

export default PopularProducts;

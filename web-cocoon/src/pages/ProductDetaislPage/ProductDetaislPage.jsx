import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Button, Spin, message, Col, Row, Input, Modal, Card } from 'antd';
import { ShoppingOutlined, PlusOutlined, MinusOutlined, LeftOutlined } from '@ant-design/icons';
import { getDetailProduct } from '../../services/ProductServices';
import { getProductByCate } from "../../services/ProductServices";
import HomePageHeader from '../../components/HeaderComponents/HomePageHeader';
import axios from 'axios';
import { jwtDecode } from 'jwt-decode';

const ProductDetailsPage = () => {
    const { _id } = useParams();
    const navigate = useNavigate();
    const [product, setProduct] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);
    const [quantity, setQuantity] = useState(1);
    const [userId, setUserId] = useState(null); // State to store userId
    const [isModalVisible, setIsModalVisible] = useState(false); // State for Modal visibility
    const [relatedProducts, setRelatedProducts] = useState([]); // sp gợi ý

    useEffect(() => {
        const storedToken = localStorage.getItem('token');
        if (storedToken) {
            try {
                const decoded = jwtDecode(storedToken); // Decode token to get userId
                setUserId(decoded.userId);
            } catch (error) {
                console.error("Failed to decode token:", error);
            }
        }
    }, []);

    useEffect(() => {
        const fetchProductDetail = async () => {
            setLoading(true);
            try {
                const productData = await getDetailProduct(_id);
                if (productData) {
                    setProduct(productData);
                } else {
                    setError("Could not fetch product details.");
                    message.error("Failed to load product details.");
                }
            } catch (err) {
                setError("Failed to load product details.");
            }
            setLoading(false);
        };
        fetchProductDetail();
    }, [_id]);

    const handleQuantityChange = (newQuantity) => {
        if (newQuantity > 0) {
            setQuantity(newQuantity);
        }
    };

    const showLoginModal = () => {
        setIsModalVisible(true);
    };

    const handleModalOk = () => {
        setIsModalVisible(false);
        navigate('/login'); // Redirect to login page
    };

    const handleModalCancel = () => {
        setIsModalVisible(false);
    };

    const handleAddToCart = async () => {
        if (!userId) {
            showLoginModal(); // Show login modal if user is not logged in
            return;
        }

        if (!_id) {
            message.error("Product ID is required");
            return;
        }

        const data = {
            userId: userId,
            productId: _id,
            quantity: quantity,
        };

        try {
            const response = await axios.post('http://localhost:4000/carts/add', data, {
                headers: {
                    "Content-Type": "application/json",
                },
            });
            if (response.status === 200) {
                message.success('Thêm sản phẩm vào giỏ hàng thành công');
            }
        } catch (error) {
            message.error('Lỗi khi thêm sản phẩm vào giỏ hàng');
            console.error(error);
        }
    };

    useEffect(() => {
        const fetchRelatedProducts = async (categoryId) => {
            try {
                const products = await getProductByCate(categoryId);
                if (products) {
                    setRelatedProducts(products);
                }
            } catch (error) {
                console.error("Failed to fetch related products:", error);
                message.error("Không thể tải sản phẩm gợi ý. Vui lòng thử lại.");
            }
        };
    
        if (product?.categoryId) {
            fetchRelatedProducts(product.categoryId);
        }
    }, [product]);
    

    const goToProductDetail = (productId) => {
        if (productId) {
            navigate(`/product/${productId}`);
        } else {
            message.error('Product ID is missing.');
        }
    };

    if (loading) return <Spin style={{ display: 'block', margin: '20px auto' }} />;
    if (error) return <p style={{ textAlign: 'center', color: 'red' }}>{error}</p>;
    if (!product) return <p>Product not found.</p>;

    return (
        <div>
            <HomePageHeader />
            <Button onClick={() => navigate(-1)} style={{ marginTop: '5px', marginLeft: '5px' }}>
                <LeftOutlined /> Go Back
            </Button>
            {/* // chi tiết */}
            <div style={{ padding: 20, margin: '0 auto' }}>
                <div style={{ flexDirection: 'column', alignItems: 'center', gap: '20px' }}>
                    <Row>
                        <Col span={10}>
                            <div style={{ marginLeft: '80px' }}>
                                {product.imageUrl && (
                                    <img
                                        src={product.imageUrl}
                                        alt="product"
                                        style={{ width: '400px', height: '400px', maxWidth: '700px', borderRadius: '5%' }}
                                    />
                                )}
                            </div>
                        </Col>
                        <Col span={14}>
                            <div style={{ maxWidth: '400px', marginLeft: '100px' }}>
                                <h1 style={{ fontSize: '24px', fontWeight: 'bold', fontFamily: '-moz-initial' }}>{product.name}</h1>
                                <p style={{ fontSize: '20px', color: 'red', fontFamily: '-moz-initial' }}>{`${product.price.toLocaleString('vi-VN')} đ`}</p>
                                <p style={{ fontSize: '16px', fontFamily: '-moz-initial' }}>{product.description}</p>

                                <div>
                                    <div>Số lượng</div>
                                    <div style={{ marginTop: 5, width: '110px', gap: 4, border: '1px solid #ccc', borderRadius: '4px', display: 'flex', alignItems: 'center' }}>
                                        <Button style={{ width: 30, height: 30, border: 'none' }} onClick={() => handleQuantityChange(quantity - 1)}>
                                            <MinusOutlined />
                                        </Button>
                                        <input
                                            value={quantity}
                                            onChange={(e) => handleQuantityChange(parseInt(e.target.value) || 1)}
                                            size='small'
                                            style={{ textAlign: 'center', width: '40px', height: 30,}}
                                        />
                                        <Button style={{ width: 30, height: 30, border: 'none' }} onClick={() => handleQuantityChange(quantity + 1)}>
                                            <PlusOutlined />
                                        </Button>
                                    </div>
                                </div>

                                <Button
                                    type="primary"
                                    icon={<ShoppingOutlined />}
                                    style={{ width: '320px', height: '50px', marginTop: '20px', background: '#000' }}
                                    onClick={handleAddToCart}
                                >
                                    <span style={{ fontSize: '16px' }}>Add to Cart</span>
                                </Button>
                            </div>
                        </Col>
                    </Row>
                </div>
            </div>

            <hr style={{ margin: 20, }}></hr>

             {/* gợi ý sp */}
            <div style={{marginLeft: 30, marginRight:30}}>
                <p style={{marginLeft: 20, fontSize: 28, fontWeight: 'bold', fontFamily: '-moz-initial'}}>Gợi ý dành cho riêng bạn</p>
                <div style={{ flex: '3', overflowX: 'auto' }}>
                    {relatedProducts.length > 0 ? (
                        <div style={{ display: 'flex' }}>
                            {relatedProducts.map((product) => (
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

            {/* Modal for login prompt */}
            <Modal
                title="Login Required"
                visible={isModalVisible}
                onOk={handleModalOk}
                onCancel={handleModalCancel}
                okText="Login"
                cancelText="Cancel"
            >
                <p>Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng của mình. Vui lòng đăng nhập để tiếp tục.</p>
            </Modal>
        </div>
    );
};

export default ProductDetailsPage;

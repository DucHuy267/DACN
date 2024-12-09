import React from "react";
import HomePageHeader from "../../components/HeaderComponents/HomePageHeader";
import { Col } from 'antd';
import { WrapperHeader } from "./style";
import ImageCarousel from "./ImageCarousel";
import Marquee from "./Marquee";
import PopularProducts from "./PopularProducts"; // Import component mới

const HomePage = () => {
    return (
        <div>
            <HomePageHeader />
            <div>
                <Marquee />
                <ImageCarousel /> 

                {/* Thêm phần Sản phẩm bán chạy */}
                <PopularProducts /> 

            </div>
        </div>
    );
};

export default HomePage;

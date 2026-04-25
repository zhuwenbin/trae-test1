class Product {
  final String id;
  final String name;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.description,
  });

  static List<Product> getMockProducts() {
    return [
      Product(
        id: '1',
        name: '时尚休闲双肩包',
        price: 129.0,
        originalPrice: 199.0,
        imageUrl: 'https://picsum.photos/400/300?random=1',
        description: '这款时尚休闲双肩包采用高品质牛津布材质，防水耐磨，大容量设计，适合日常通勤和短途旅行。',
      ),
      Product(
        id: '2',
        name: '智能运动手表',
        price: 299.0,
        originalPrice: 499.0,
        imageUrl: 'https://picsum.photos/400/300?random=2',
        description: '智能运动手表，支持心率监测、睡眠追踪、运动数据记录等功能，防水设计，续航长达7天。',
      ),
      Product(
        id: '3',
        name: '无线蓝牙耳机',
        price: 159.0,
        originalPrice: 249.0,
        imageUrl: 'https://picsum.photos/400/300?random=3',
        description: '真无线蓝牙耳机，采用最新蓝牙5.3技术，音质清晰，降噪效果出色，续航长达30小时。',
      ),
      Product(
        id: '4',
        name: '便携式充电宝',
        price: 89.0,
        originalPrice: 129.0,
        imageUrl: 'https://picsum.photos/400/300?random=4',
        description: '20000mAh大容量充电宝，支持22.5W快充，双向快充技术，轻薄便携，适合外出旅行。',
      ),
      Product(
        id: '5',
        name: '简约风格台灯',
        price: 69.0,
        originalPrice: 99.0,
        imageUrl: 'https://picsum.photos/400/300?random=5',
        description: '简约风格台灯，三档亮度调节，护眼设计，USB充电接口，适合办公学习使用。',
      ),
      Product(
        id: '6',
        name: '运动健身套装',
        price: 199.0,
        originalPrice: 299.0,
        imageUrl: 'https://picsum.photos/400/300?random=6',
        description: '运动健身套装，包含速干运动T恤和运动短裤，透气舒适，弹力面料，适合各种运动场景。',
      ),
      Product(
        id: '7',
        name: '高清摄像头',
        price: 149.0,
        originalPrice: 219.0,
        imageUrl: 'https://picsum.photos/400/300?random=7',
        description: '1080P高清摄像头，支持自动对焦，内置麦克风，适用于视频会议、直播等场景。',
      ),
      Product(
        id: '8',
        name: '机械键盘',
        price: 249.0,
        originalPrice: 349.0,
        imageUrl: 'https://picsum.photos/400/300?random=8',
        description: '机械键盘，青轴手感，RGB背光，87键紧凑布局，适合游戏和办公使用。',
      ),
      Product(
        id: '9',
        name: '无线鼠标',
        price: 79.0,
        originalPrice: 119.0,
        imageUrl: 'https://picsum.photos/400/300?random=9',
        description: '静音无线鼠标，人体工学设计，2.4G无线连接，续航长达12个月。',
      ),
      Product(
        id: '10',
        name: '笔记本支架',
        price: 59.0,
        originalPrice: 89.0,
        imageUrl: 'https://picsum.photos/400/300?random=10',
        description: '铝合金笔记本支架，可调节高度，散热设计，适用于10-17英寸笔记本电脑。',
      ),
      Product(
        id: '11',
        name: '手机支架',
        price: 39.0,
        originalPrice: 59.0,
        imageUrl: 'https://picsum.photos/400/300?random=11',
        description: '多功能手机支架，可360度旋转，适用于桌面、床头等多种场景，支持4.7-12.9英寸设备。',
      ),
      Product(
        id: '12',
        name: 'USB-C扩展坞',
        price: 129.0,
        originalPrice: 199.0,
        imageUrl: 'https://picsum.photos/400/300?random=12',
        description: '7合1 USB-C扩展坞，包含HDMI、USB 3.0、SD卡读卡器、PD充电等接口，轻薄便携。',
      ),
    ];
  }
}

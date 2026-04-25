import 'package:get/get.dart';
import '../models/order.dart';

class AddressController extends GetxController {
  final RxList<ShippingAddress> _addresses = <ShippingAddress>[].obs;
  final Rxn<ShippingAddress> _selectedAddress = Rxn<ShippingAddress>();

  List<ShippingAddress> get addresses => _addresses;
  ShippingAddress? get selectedAddress => _selectedAddress.value;
  ShippingAddress? get defaultAddress {
    try {
      return _addresses.firstWhere((addr) => addr.isDefault);
    } catch (e) {
      return _addresses.isNotEmpty ? _addresses.first : null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initMockData();
  }

  void _initMockData() {
    final mockAddresses = [
      ShippingAddress(
        id: '1',
        name: '张三',
        phone: '13812348888',
        province: '广东省',
        city: '深圳市',
        district: '南山区',
        detail: '科技园路123号 创意大厦A栋1001室',
        isDefault: true,
      ),
      ShippingAddress(
        id: '2',
        name: '李四',
        phone: '13999996666',
        province: '北京市',
        city: '北京市',
        district: '朝阳区',
        detail: '建国路88号SOHO现代城B座2005室',
        isDefault: false,
      ),
    ];
    _addresses.assignAll(mockAddresses);
  }

  void addAddress(ShippingAddress address) {
    if (address.isDefault) {
      _clearDefault();
    }
    if (_addresses.isEmpty) {
      _addresses.add(address.copyWith(isDefault: true));
    } else {
      _addresses.add(address);
    }
  }

  void updateAddress(ShippingAddress address) {
    final index = _addresses.indexWhere((addr) => addr.id == address.id);
    if (index >= 0) {
      if (address.isDefault) {
        _clearDefault();
      }
      _addresses[index] = address;
    }
  }

  void deleteAddress(String id) {
    _addresses.removeWhere((addr) => addr.id == id);
    if (_selectedAddress.value?.id == id) {
      _selectedAddress.value = null;
    }
  }

  void setDefaultAddress(String id) {
    _clearDefault();
    final index = _addresses.indexWhere((addr) => addr.id == id);
    if (index >= 0) {
      _addresses[index] = _addresses[index].copyWith(isDefault: true);
    }
  }

  void _clearDefault() {
    for (int i = 0; i < _addresses.length; i++) {
      if (_addresses[i].isDefault) {
        _addresses[i] = _addresses[i].copyWith(isDefault: false);
      }
    }
  }

  void selectAddress(ShippingAddress? address) {
    _selectedAddress.value = address;
  }

  ShippingAddress? getSelectedOrDefault() {
    if (_selectedAddress.value != null) {
      return _selectedAddress.value;
    }
    return defaultAddress;
  }

  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  bool validatePhone(String phone) {
    if (phone.length != 11) return false;
    final phoneReg = RegExp(r'^1[3-9]\d{9}$');
    return phoneReg.hasMatch(phone);
  }
}

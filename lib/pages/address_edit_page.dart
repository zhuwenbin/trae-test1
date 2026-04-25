import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:get/get.dart';
import '../controllers/address_controller.dart';
import '../models/order.dart';

class AddressEditPage extends StatefulWidget {
  const AddressEditPage({super.key});

  @override
  State<AddressEditPage> createState() => _AddressEditPageState();
}

class _AddressEditPageState extends State<AddressEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _regionController;
  late final TextEditingController _detailController;
  
  bool _isDefault = false;
  String _province = '';
  String _city = '';
  String _district = '';
  
  ShippingAddress? _editAddress;
  late AddressController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = Get.find<AddressController>();
    _editAddress = Get.arguments as ShippingAddress?;
    
    _nameController = TextEditingController(text: _editAddress?.name ?? '');
    _phoneController = TextEditingController(text: _editAddress?.phone ?? '');
    _detailController = TextEditingController(text: _editAddress?.detail ?? '');
    
    if (_editAddress != null) {
      _province = _editAddress!.province;
      _city = _editAddress!.city;
      _district = _editAddress!.district;
      _isDefault = _editAddress!.isDefault;
      _regionController = TextEditingController(
        text: '$_province $_city $_district',
      );
    } else {
      _regionController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _regionController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editAddress != null ? '编辑地址' : '新增地址',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey[50],
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              _buildFormCard(),
              const SizedBox(height: 12),
              _buildDefaultSwitch(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildSaveButton(),
    );
  }

  Widget _buildFormCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildFormField(
            label: '收货人',
            controller: _nameController,
            hintText: '请输入收货人姓名',
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '请输入收货人姓名';
              }
              return null;
            },
          ),
          const Divider(height: 1, indent: 16),
          _buildFormField(
            label: '手机号码',
            controller: _phoneController,
            hintText: '请输入手机号码',
            keyboardType: TextInputType.phone,
            maxLength: 11,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '请输入手机号码';
              }
              if (!_addressController.validatePhone(value.trim())) {
                return '请输入正确的11位手机号';
              }
              return null;
            },
          ),
          const Divider(height: 1, indent: 16),
          _buildRegionField(),
          const Divider(height: 1, indent: 16),
          _buildFormField(
            label: '详细地址',
            controller: _detailController,
            hintText: '请输入街道、楼牌号等详细地址',
            maxLines: 2,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '请输入详细地址';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLength,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
                border: InputBorder.none,
                counterText: '',
                errorStyle: const TextStyle(height: 0.8),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionField() {
    return GestureDetector(
      onTap: _showRegionPicker,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 80,
              child: Text(
                '所在地区',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _regionController,
                  decoration: InputDecoration(
                    hintText: '请选择省市区',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  validator: (value) {
                    if (_province.isEmpty || _city.isEmpty) {
                      return '请选择所在地区';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultSwitch() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            '设为默认地址',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Switch(
            value: _isDefault,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                _isDefault = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: _saveAddress,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Text(
              '保存',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showRegionPicker() {
    Pickers.showAddressPicker(
      context,
      pickerStyle: DefaultPickerStyle(),
      onConfirm: (province, city, district) {
        setState(() {
          _province = province ?? '';
          _city = city ?? '';
          _district = district ?? '';
          _regionController.text = '$_province $_city $_district';
        });
      },
    );
  }

  void _saveAddress() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_province.isEmpty || _city.isEmpty) {
      Get.snackbar(
        '提示',
        '请选择所在地区',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final detail = _detailController.text.trim();

    final address = ShippingAddress(
      id: _editAddress?.id ?? _addressController.generateId(),
      name: name,
      phone: phone,
      province: _province,
      city: _city,
      district: _district,
      detail: detail,
      isDefault: _isDefault,
    );

    if (_editAddress != null) {
      _addressController.updateAddress(address);
      Get.snackbar(
        '成功',
        '地址修改成功',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      _addressController.addAddress(address);
      Get.snackbar(
        '成功',
        '地址添加成功',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }

    Get.back();
  }
}

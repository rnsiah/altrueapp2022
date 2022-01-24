import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/company_model.dart';
import 'package:mobile/Presentation/Widgets/company/company_background.dart';
import 'package:mobile/Presentation/Widgets/company/company_details_content.dart';

class CompanYDetailPage extends StatefulWidget {
  final ForProfitCompany company;

  const CompanYDetailPage({Key? key, required this.company}) : super(key: key);

  @override
  _CompanYDetailPageState createState() => _CompanYDetailPageState();
}

class _CompanYDetailPageState extends State<CompanYDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CompanyDetailsBackground(company: widget.company),
          CompanyDetailsContent(
            company: widget.company,
          )
        ],
      ),
    );
  }
}

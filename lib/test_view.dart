import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  List<String> _years = [];
  String? _selectedYear;
  String? _selectedMonth;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    // Get the current year
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;

    // Generate a list of years from 2000 to the current year
    _years =
        List.generate(currentYear - 1999, (index) => (2000 + index).toString());

    // Set the current year as the selected value
    _selectedYear = currentYear.toString();
    _selectedMonth = currentMonth.toString();
    _selectedStatus = "All";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text("We Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Filters",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownMenu(
                      menuHeight: 300,
                      initialSelection: _selectedYear,
                      helperText: "Year",
                      dropdownMenuEntries: _years
                          .map((item) =>
                              DropdownMenuEntry(value: item, label: item))
                          .toList()),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownMenu(
                      menuHeight: 300,
                      initialSelection: _selectedMonth,
                      helperText: "Month",
                      dropdownMenuEntries: [
                        DropdownMenuEntry(value: "1", label: "Jan"),
                        DropdownMenuEntry(value: "2", label: "Feb"),
                        DropdownMenuEntry(value: "3", label: "Mar"),
                        DropdownMenuEntry(value: "4", label: "Apr"),
                        DropdownMenuEntry(value: "5", label: "May"),
                        DropdownMenuEntry(value: "6", label: "Jun"),
                        DropdownMenuEntry(value: "7", label: "Jul"),
                        DropdownMenuEntry(value: "8", label: "Aug"),
                        DropdownMenuEntry(value: "9", label: "Sept"),
                        DropdownMenuEntry(value: "10", label: "Oct"),
                        DropdownMenuEntry(value: "11", label: "Nov"),
                        DropdownMenuEntry(value: "12", label: "Dec"),
                      ]),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showFilters();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          height: 55,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_selectedStatus!),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            "Status",
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showFilters() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(20))),
        context: context,
        builder: (context) => Padding(
          padding:
          EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.filter_alt_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text(
                            "Filter By Status",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontSize: 17,
                                color:
                                Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Theme.of(context).primaryColor),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the bottom sheet
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                StatefulBuilder(builder: (context, setState1) => Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context)
                                        .primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              Radio(
                                  value: "All",
                                  groupValue: _selectedStatus,
                                  onChanged: (String? val) {
                                    setState(() {
                                      _selectedStatus = val;
                                    });
                                    setState1(() {
                                      _selectedStatus = val;
                                    });
                                  })
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Active",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context)
                                        .primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              Radio(
                                  value: "Active",
                                  groupValue: _selectedStatus,
                                  onChanged: (String? val) {
                                    setState(() {
                                      _selectedStatus = val;
                                    });
                                    setState1(() {
                                      _selectedStatus = val;
                                    });
                                  })
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Inactive",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context)
                                        .primaryColor,
                                    fontWeight: FontWeight.w400),
                              ),
                              Radio(
                                  value: "Inactive",
                                  groupValue: _selectedStatus,
                                  onChanged: (String? val) {
                                    setState(() {
                                      _selectedStatus = val;
                                    });
                                    setState1(() {
                                      _selectedStatus = val;
                                    });
                                  })
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
               ],
            ),
          ),
        ));
  }
}

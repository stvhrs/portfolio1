import 'package:flutter/material.dart';
import 'package:cahaya/helper/format_tanggal.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

class SearchTanggal extends StatefulWidget {
const SearchTanggal({super.key});
@override
State<SearchTanggal> createState() => _SearchTanggalState();
}


class _SearchTanggalState extends State<SearchTanggal> {
  String _selecteRange = 'Pilih Rentang';
  DateTimeRange? picked;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 36,
      child: Card(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.date_range_rounded,size: 18),
              InkWell(
                child: Text(
                  _selecteRange,
                ),
                onTap: () async {
                  dateTimeRangePicker() async {
                    picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 4),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Column(
                            children: [
                              ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 600, minHeight: 500),
                                  child: Theme(
                                    data: ThemeData(
                                      colorScheme: ColorScheme.light(
                                        primary: Theme.of(context).primaryColor,
                                        surface: const Color.fromARGB(255, 75, 84, 167),
                                      ),

                                      // Here I Chaged the overline to my Custom TextStyle.
                                      textTheme: const TextTheme(
                                          overline: TextStyle(fontSize: 16)),
                                      dialogBackgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: child!,
                                  ))
                            ],
                          );
                        });
           
                    if (picked != null) {
                      _selecteRange = FormatTanggal.formatTanggal(
                              picked!.start.toIso8601String()) +
                          ' - ' +
                          FormatTanggal.formatTanggal(
                              picked!.end.toIso8601String());
                      Provider.of<ProviderData>(context, listen: false).start =
                          picked!.start;
                      Provider.of<ProviderData>(context, listen: false).end =
                          picked!.end;
                      Provider.of<ProviderData>(context, listen: false)
                          .searchTransaksi("",true);
                      setState(() {});
                    }

                  }

                  dateTimeRangePicker();
                },
              ),
              _selecteRange == 'Pilih Rentang'
                  ? IconButton(onPressed: (){}, icon: const Icon(Icons.r_mobiledata,color: Colors.transparent,))
                  : IconButton(
                      onPressed: () {
                        picked = null;
                        _selecteRange = 'Pilih Rentang';
                        Provider.of<ProviderData>(context, listen: false).start =
                            null;
                        Provider.of<ProviderData>(context, listen: false).end =
                            null;
                        Provider.of<ProviderData>(context, listen: false)
                            .searchTransaksi("",true);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}

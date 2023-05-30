import 'package:flutter/material.dart';
import 'package:cahaya/helper/format_tanggal.dart';
import 'package:cahaya/providerData/providerData.dart';
import 'package:provider/provider.dart';

class SearchMutasi extends StatefulWidget {
const SearchMutasi({super.key});
@override
State<SearchMutasi> createState() => _SearchMutasiState();
}


class _SearchMutasiState extends State<SearchMutasi> {
  String _selecteRange = 'Pilih Rentang';
  DateTimeRange? picked;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.date_range_rounded,size: 25),
            InkWell(
              child: Text(
                _selecteRange,
              ),
              onTap: () async {
                dateTimeRangePicker() async {
                  picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 4),
                      lastDate: DateTime.now().add(const Duration(days: 1)),
                      builder: (context, child) {
                        return Column(
                          children: [
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                    maxWidth: 600, minHeight: 500),
                                child: Theme(
                                  data: ThemeData(
                                    colorScheme:  ColorScheme.light(
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
                    Provider.of<ProviderData>(context, listen: false).startMutasi =
                        picked!.start;
                    Provider.of<ProviderData>(context, listen: false).endMutasi =
                        picked!.end;
                    Provider.of<ProviderData>(context, listen: false)
                        .searchHistorySaldo();
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
                      Provider.of<ProviderData>(context, listen: false).startMutasi =
                          null;
                      Provider.of<ProviderData>(context, listen: false).endMutasi =
                          null;
                      Provider.of<ProviderData>(context, listen: false)
                          .searchHistorySaldo();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ))
          ],
        ),
      
    );
  }
}

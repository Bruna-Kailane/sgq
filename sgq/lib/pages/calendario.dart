import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgq/models/reserve.dart';
import 'package:sgq/pages/cadastro_reserva.dart';
import 'package:sgq/repositories/repositorio_reserve.dart';
import 'package:sgq/repositories/repositorio_users.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendario extends StatefulWidget {
  const Calendario({Key? key}) : super(key: key);

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late ValueNotifier<List<Reserve>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var repositorio = Provider.of<RepositorioReserve>(context);
    var lista = repositorio.reservas;
    var repUser = Provider.of<RepositorioUsers>(context, listen: false);
    String professor;
    String autor;

    List<Reserve> getEventsForDay(DateTime day) {
      List<Reserve> reservaDay = [];

      for (var reserva in lista) {
        if (reserva.reserveStatus == 1) {
          DateTime tempDate =
              DateFormat("yyyy-MM-dd hh:mm:ss").parse(reserva.date);
          if (tempDate.day == day.day &&
              tempDate.month == day.month &&
              tempDate.year == day.year) {
            reservaDay.add(reserva);
          }
        }
      }
      return reservaDay;
    }

    void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      if (!isSameDay(_selectedDay, selectedDay)) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });

        _selectedEvents.value = getEventsForDay(selectedDay);
      }
    }

    _selectedEvents = ValueNotifier(getEventsForDay(_selectedDay!));

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black87,
                    blurRadius: 5,
                    offset: Offset(0.0, 5),
                  )
                ]),
            child: TableCalendar(
              firstDay: DateTime.utc(2021, 10, 16),
              lastDay: DateTime.utc(2022, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              eventLoader: getEventsForDay,
              onDaySelected: _onDaySelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Reserve>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        title: Text(
                            '${value[index].description} - ${repUser.buscaId(value[index].keeperUserId).name} e ${repUser.buscaId(value[index].authorUserId).name} '),
                        trailing: Text(
                            "${value[index].begin} - ${value[index].finish}",
                            style: const TextStyle(color: Colors.grey)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.of(context).pushNamed(CadastroReserva.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

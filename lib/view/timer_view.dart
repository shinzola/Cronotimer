import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/timer_viewmodel.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TimerViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cronômetro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              label: 'Tempo decorrido',
              value: vm.formattedElapsed,
              liveRegion: true,
              child: Center(
                child: Text(
                  vm.formattedElapsed,
                  style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: vm.isRunning ? vm.pause : vm.start,
                  icon: Icon(vm.isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(vm.isRunning ? 'Pausar' : 'Iniciar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: vm.reset,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reiniciar'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: vm.isRunning ? vm.lap : null,
                  icon: const Icon(Icons.flag),
                  label: const Text('Volta'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Voltas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: vm.laps.isEmpty
                  ? const Center(child: Text('Nenhuma volta registrada'))
                  : ListView.builder(
                      itemCount: vm.laps.length,
                      itemBuilder: (context, idx) {
                        // remember: vm.laps já vem reversa (mais recente primeiro)
                        final lap = vm.laps[idx];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          title: Semantics(
                            label: 'Volta ${lap.index}',
                            value:
                                'Tempo da volta ${_formatDurationShort(lap.lapTime)}, total ${_formatDurationShort(lap.totalTime)}',
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Volta ${lap.index}'),
                                Text(_formatDurationShort(lap.lapTime)),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            'Total: ${_formatDurationShort(lap.totalTime)}',
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatDurationShort(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final centi = (d.inMilliseconds.remainder(1000) ~/ 10).toString().padLeft(
      2,
      '0',
    );
    if (d.inHours > 0) {
      return '${d.inHours}:$minutes:$seconds.$centi';
    }
    return '$minutes:$seconds.$centi';
  }
}

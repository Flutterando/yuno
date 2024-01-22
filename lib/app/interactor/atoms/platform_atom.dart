import 'package:asp/asp.dart';

import '../models/platform_model.dart';

final platformsState = Atom<List<PlatformModel>>([]);

final platformSyncState = Atom<Set<int>>({});
bool get isPlatformSyncing => platformSyncState.value.isNotEmpty;

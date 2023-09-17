//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <week_pick_button/week_pick_button_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) week_pick_button_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WeekPickButtonPlugin");
  week_pick_button_plugin_register_with_registrar(week_pick_button_registrar);
}

/*
 * SPDX-License-Identifier: GPL-3.0
 * SPDX-FileCopyrightText: 2025 Cassidy James Blaede <c@ssidyjam.es>
 */

public class Vibes.App : Adw.Application {

    private const string RESOURCE_ROOT = "/com/cassidyjames/vibes/wallpapers/";

    private MainWindow main_window;

    public App () {
        Object (
            application_id: APP_ID,
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        main_window = new MainWindow (this);
        main_window.show ();

        load_pictures_async.begin ((obj, res) => {
            load_pictures_async.end (res);
        });
    }

    protected override void startup () {
        base.startup ();

        add_action_entries ({
            { "quit", quit }
        }, this);

        set_accels_for_action ("app.quit", {
            "<primary>q",
            "<primary>w"
        });
    }

    private async void load_pictures_async () {
        GLib.SourceFunc callback = load_pictures_async.callback;
        new GLib.Thread<void> ("load-pictures", () => {
            try {
                foreach (string wallpaper in GLib.resources_enumerate_children (RESOURCE_ROOT, GLib.ResourceLookupFlags.NONE)) {
                    main_window.add_picture (RESOURCE_ROOT + wallpaper);
                }
            } catch (GLib.Error e) {
                // TODO: Properly handle this
                warning (e.message);
            }
            Idle.add ((owned) callback);
        });
        yield;
    }

    private static int main (string[] args) {
        var app = new App ();
        return app.run (args);
    }
}

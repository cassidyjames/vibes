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
            "<Control>q",
            "<Control>w"
        });
    }

    private async void load_pictures_async () {
        GLib.SourceFunc callback = load_pictures_async.callback;
        new GLib.Thread<void> ("load-pictures", () => {
            try {
                GLib.File wallpapers_dir = GLib.File.new_for_path (WALLPAPERS_DIR);
                GLib.FileEnumerator file_enumerator = wallpapers_dir.enumerate_children ("standard::*", GLib.FileQueryInfoFlags.NOFOLLOW_SYMLINKS, null);
                GLib.FileInfo? file_info = null;
                while ((file_info = file_enumerator.next_file ()) != null) {
                    GLib.File wallpaper = GLib.File.new_build_filename (wallpapers_dir.get_path (), file_info.get_name ());
                    main_window.add_picture (wallpaper.get_path ());
                }
            } catch (GLib.Error e) {
                warning ("Failed to enumerate wallpaper files: %s", e.message);
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
